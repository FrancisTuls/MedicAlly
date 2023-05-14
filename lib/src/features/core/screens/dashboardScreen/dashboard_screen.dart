import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/controllers/medicine_reminder.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/add_med_floating_button.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/home_dash_addmedbar_widget.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/home_dash_appbar_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/med_rem_tile.dart';
import 'package:provider/provider.dart';

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

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
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
          CalendarContainer(onDateSelected: _onDateSelected),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Consumer<DateProvider>(
                builder: (context, dateProvider, child) =>
                    _showMedSched(dateProvider.selectedDate),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const AddMedFloating(),
    );
  }

  Widget _showMedSched(DateTime selectedDate) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('MedicineReminder')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final docs = snapshot.data!.docs;
            if (docs.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: docs.length,
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final medName = doc.exists ? doc.get('medName') : '';
                  final remTime = doc.exists ? doc.get('remTime') : '';
                  final completed =
                      doc.exists ? doc.get('isCompleted').toString() : '';
                  final container = doc.get('id');
                  final startDate = doc.exists ? doc.get('startDate') : '';
                  final dosage = doc.exists ? doc.get('dosage').toString() : '';

                  /*if (remTime == null || remTime.isEmpty) {
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
                                  //deleteReminder(doc.id);
                                  _showBottomSheet(context, doc.id);
                                },
                                child: MedTile(
                                  medName: medName,
                                  remTime: remTime,
                                  completed: completed,
                                  container: container,
                                  date: startDate,
                                  dosage: dosage,
                                ),
                              )
                            ],
                          )),
                        ));
                  }*/

                  if (startDate == selectedDate) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //deleteReminder(doc.id);
                                  _showBottomSheet(context, doc.id);
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
                  } else if (remTime == null || remTime.isEmpty) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    mNoMedicinealt,
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No Medicines Added Yet.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
          } else {
            return const Text('Loading...');
          }
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String docId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'What would you like to do?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: () {
                  Get.toNamed('/addmed');
                },
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                child: const Text(mModalEdit,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete reminder?'),
                      content: const Text(
                          'Are you sure you want to delete this reminder?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // delete reminder
                            deleteReminder(docId);
                            Navigator.pop(context);
                            Get.back();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.redAccent),
                child: const Text(mModalDelete,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }

  /*_showMedSched() {
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
  }*/

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
