//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/controllers/medicine_reminder.dart';
import 'package:medic_ally/src/features/core/models/med_details.dart';
import 'package:medic_ally/src/features/core/models/med_reminder.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_appbar.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_med.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_sched.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_time.dart';
import 'package:provider/provider.dart';

class AddSched extends StatelessWidget {
  AddSched({super.key});

  final MedReminderController _medController = Get.put(MedReminderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddSchedAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AddSchedCard(),
              const SizedBox(height: 10),
              //const AddSchedCardTime(),
              const AddSchedCardSched(),
              const SizedBox(height: 10),
              FilledButton.tonal(
                onPressed: () {
                  _addMedReminderToDB(context);
                  Get.offNamed('/botnavbar');
                },
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                child: const Text(mDone,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addMedReminderToDB(BuildContext context) async {
    final selectedDateProvider =
        Provider.of<SelectedDateProvider>(context, listen: false);
    final selectedDate = selectedDateProvider.selectedDate;
    final selectedTimeProvider =
        Provider.of<SelectedTimeProvider>(context, listen: false);
    final selectedTime = selectedTimeProvider.selectedTime;
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    final dosage =
        Provider.of<SelectedDosage>(context, listen: false).selectedNumber;

    final selectedContainer =
        Provider.of<SelectedCircleProvider>(context, listen: false)
            .selectedCircle;

    final currentUser = FirebaseAuth.instance.currentUser;
    final medDetailsDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser?.uid)
        .collection('MedicineDetails')
        .doc(selectedContainer.toString())
        .get();
    final medName = medDetailsDoc['medName'];
    final stock = medDetailsDoc['stock'];
    final container = medDetailsDoc['container'];

    final med = MedReminder(
      id: null,
      medName: medName,
      stock: stock,
      dosage: dosage,
      isCompleted: 0,
      startDate:
          DateFormat.yMd().format(selectedDate) /*selectedDate.toString()*/,
      remTime: selectedTime.toString(),
      container: container,
    );

    if (currentUser != null) {
      final userDocRef = usersCollection.doc(currentUser.uid);
      await userDocRef
          .collection('MedicineReminder')
          .doc(selectedContainer.toString())
          .set(med.toJson());
    }
  }
}
