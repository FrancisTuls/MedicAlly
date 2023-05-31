import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/features/core/models/med_reminder.dart';

class MedReminderController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var medList = <MedReminder>[].obs;

  void getMedReminders() async {
    final collection =
        FirebaseFirestore.instance.collection('MedicineReminder');
    final snapshot = await collection.get();
    medList.assignAll(
      snapshot.docs
          .map(
            (doc) => MedReminder(
              id: int.parse(doc.id),
              medName: doc.data()['medName'],
              remTime: doc.data()['remTime'],
            ),
          )
          .toList(),
    );
  }
}
