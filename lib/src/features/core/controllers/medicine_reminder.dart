import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/features/core/models/med_reminder.dart';

class MedReminderController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var medList = <MedReminder>[].obs;

  /*Future<void>? addMed({MedReminder? med}) async {
    return await DBHelper.insert()
  }*/

  void addMedRemindersToUser(String userId) async {
    final userRef = FirebaseFirestore.instance.collection('Users').doc(userId);
    final medRemindersCollection =
        FirebaseFirestore.instance.collection('MedicineReminder');
    final snapshot = await medRemindersCollection.get();
    final medList = snapshot.docs
        .map(
          (doc) => MedReminder(
            id: doc.id,
            medName: doc.data()['medName'],
            remTime: doc.data()['remTime'],
          ),
        )
        .toList();

    await userRef.update({'medReminders': medList});
  }
}