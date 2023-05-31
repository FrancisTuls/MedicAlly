import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:medic_ally/services/notification_services.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
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
  var notificationService;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    notificationService = NotificationService();
    notificationService.initNotification();
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
    return ChangeNotifierProvider<DateProvider>(
      create: (context) =>
          DateProvider(), // Provide an instance of DateProvider
      child: Scaffold(
        appBar: const DashAppbar(),
        body: Column(
          children: [
            const DashAddmed(),
            CalendarContainer(onDateSelected: _onDateSelected),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<DateProvider>(
                builder: (context, dateProvider, child) =>
                    _showMedSched(dateProvider.selectedDate),
              ),
            ),
          ],
        ),
        floatingActionButton: const AddMedFloating(),
      ),
    );
  }

  Widget _showMedSched(DateTime selectedDate) {
    final DateTime startDate = selectedDate.subtract(const Duration(days: 1));
    final DateTime endDate = selectedDate.add(const Duration(days: 1));

    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('MedicineReminder').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final docs = snapshot.data!.docs;
          final filteredDocs = docs.where((doc) {
            final startDateStr = doc.get('startDate');
            final endDateStr = doc.get('endDate');
            final startDateFormatted = DateFormat.yMd().parse(startDateStr);
            final endDateFormatted = DateFormat.yMd().parse(endDateStr);
            return startDateFormatted.isBefore(endDate) &&
                endDateFormatted.isAfter(startDate);
          }).toList();

          // Sort the filteredDocs list based on remTime
          filteredDocs.sort((a, b) {
            final remTimeA = a.get('remTime');
            final remTimeB = b.get('remTime');

            if (remTimeA == null || remTimeB == null) {
              return 0;
            }

            final timeA = DateFormat('hh:mm a').parse(remTimeA);
            final timeB = DateFormat('hh:mm a').parse(remTimeB);

            return timeA.compareTo(timeB);
          });

          if (filteredDocs.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: filteredDocs.length,
              itemBuilder: (context, index) {
                final doc = filteredDocs[index];
                final medName = doc.exists ? doc.get('medName') : '';
                final remTime = doc.exists ? doc.get('remTime') : '';
                final completed =
                    doc.exists ? doc.get('isCompleted').toString() : '';
                final container = doc.get('id');
                final startDate = doc.exists ? doc.get('startDate') : '';
                final dosage = doc.exists ? doc.get('dosage').toString() : '';
                final stock = doc.exists ? doc.get('stock') : 0;

                DateTime time = DateFormat('h:mm a').parse(remTime);
                var myTime = DateFormat("HH:mm").format(time);
                notificationService.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    container,
                    medName,
                    dosage,
                    stock);

                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                  context, doc.id, medName, container, stock);
                            },
                            child: MedTile(
                              medName: medName,
                              remTime: remTime,
                              completed: completed,
                              container: container,
                              date:
                                  DateFormat('M/dd/yyyy').format(selectedDate),
                              dosage: dosage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
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
    );
  }

  void _showBottomSheet(BuildContext context, String docId, String medName,
      int container, int stock) {
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
                  Provider.of<AddMedicineName>(context, listen: false)
                      .addMedicineName(medName);
                  Provider.of<SelectedCircleProvider>(context, listen: false)
                      .addSelectedCircle(container);
                  Provider.of<AddMedicineStock>(context, listen: false)
                      .addSelectedStock(stock);
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

  void deleteReminder(String docId) async {
    await FirebaseFirestore.instance
        .collection('MedicineReminder')
        .doc(docId)
        .delete();
  }
}
