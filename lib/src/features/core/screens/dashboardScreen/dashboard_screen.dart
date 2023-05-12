import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/controllers/medicine_reminder.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/add_med_floating_button.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/home_dash_addmedbar_widget.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/home_dash_appbar_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/med_rem_tile.dart';

import 'widgets/home_dash_calendar_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 2));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: const DashAppbar(),
      body: Column(
        children: [
          const DashAddmed(),
          const CalendarContainer(),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: _showMedSched(),
            ),
          ),
        ],
      ),
      floatingActionButton: const AddMedFloating(),
    );
  }

  _showMedSched() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('MedicineReminder')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final docs = snapshot.data!.docs;
            if (docs.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: docs.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final medName = doc.exists ? doc.get('medName') : '';
                  final remTime = doc.exists ? doc.get('remTime') : '';
                  final completed =
                      doc.exists ? doc.get('isCompleted').toString() : '';
                  final container =
                      doc.exists ? doc.get('container').toString() : '';
                  final startDate = doc.exists ? doc.get('startDate') : '';
                  final dosage = doc.exists ? doc.get('dosage').toString() : '';

                  if (remTime == null || remTime.isEmpty) {
                    return Container();
                  } else {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  deleteReminder(doc.id);
                                },
                                child: MedTile(
                                  medName: medName,
                                  remTime: remTime,
                                  completed: completed,
                                  container: int.parse(container),
                                  date: startDate,
                                  dosage: dosage,
                                ),
                              )
                            ],
                          )),
                        ));
                  }
                },
              );
            } else {
              return const Center(
                  child: Text(
                'No Medicines Added Yet.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ));
            }
          } else {
            return const Text('Loading...');
          }
        },
      ),
    );
  }

  void deleteReminder(String docId) async {
    final doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('MedicineReminder')
        .doc(docId)
        .get();

    if (doc.exists) {
      final remTime = doc.get('remTime');
      final startDate = doc.get('startDate');

      if (remTime != null || startDate != null) {
        await doc.reference.update({'remTime': null, 'startDate': null});
      }
    }
  }
}
