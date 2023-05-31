import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/controllers/medicine_reminder.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_appbar.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_med.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_sched.dart';
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
              FilledButton(
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

  _addMedReminderToDB(BuildContext context) async {
    final selectedDateProvider =
        Provider.of<SelectedDateProvider>(context, listen: false);
    final selectedDate = selectedDateProvider.selectedDate;
    final selectedEndDateProvider =
        Provider.of<SelectedEndDateProvider>(context, listen: false);
    final selectedEndDate = selectedEndDateProvider.selectedEndDate;
    final selectedTimeProvider =
        Provider.of<SelectedTimeProvider>(context, listen: false);
    final selectedTime = selectedTimeProvider.selectedTime;
    final CollectionReference medReminderCollection =
        FirebaseFirestore.instance.collection('MedicineReminder');
    final dosage =
        Provider.of<SelectedDosage>(context, listen: false).selectedNumber;

    final selectedContainer =
        Provider.of<SelectedCircleProvider>(context, listen: false)
            .selectedCircle;

    // Create a map of the new fields to be added
    final newFields = {
      'dosage': dosage,
      'isCompleted': 0,
      'startDate': DateFormat.yMd().format(selectedDate),
      'endDate': DateFormat.yMd().format(selectedEndDate!),
      'remTime': selectedTime.toString(),
    };

    // Update the document with the new fields
    medReminderCollection.doc(selectedContainer.toString()).update(newFields);
  }
}
