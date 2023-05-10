//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/models/med_details.dart';
import 'package:medic_ally/src/features/core/models/med_reminder.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_appbar.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_med.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_sched.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_time.dart';
import 'package:provider/provider.dart';

class AddSched extends StatelessWidget {
  const AddSched({super.key});

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
              //const AddSchedCardTime(),
              const AddSchedCardSched(),
              const SizedBox(height: 20),
              FilledButton.tonal(
                onPressed: () {
                  _addMedReminderToDB(context);
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

  _addMedReminderToDB(BuildContext context) async {
    final selectedDateProvider = Provider.of<SelectedDateProvider>(context);
    final selectedDate = selectedDateProvider.selectedDate;
    final selectedTimeProvider = Provider.of<SelectedTimeProvider>(context);
    final selectedTime = selectedTimeProvider.selectedTime;
    final CollectionReference medReminderCollection =
        FirebaseFirestore.instance.collection('MedicineReminder');
    final dosage =
        Provider.of<SelectedDosage>(context, listen: false).selectedNumber;

    final selectedContainer =
        Provider.of<SelectedCircleProvider>(context, listen: false)
            .selectedCircle;

    final medDetailsDoc = await FirebaseFirestore.instance
        .collection('MedicineDetails')
        .doc(selectedContainer.toString())
        .get();
    final medName = medDetailsDoc['medName'];
    final stock = medDetailsDoc['stock'];
    final container = medDetailsDoc['container'];

    final medReminder = MedReminder(
      id: null,
      medName: medName,
      stock: stock,
      dosage: dosage,
      isCompleted: 0,
      startDate: selectedDate.toString(),
      remTime: selectedTime.toString(),
      container: container,
    );
    medReminderCollection
        .doc(selectedContainer.toString())
        .set(medReminder.toJson());
  }
}
