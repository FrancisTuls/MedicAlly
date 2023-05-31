import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class NotifiedPage extends StatefulWidget {
  final String? label;
  const NotifiedPage({super.key, required this.label});

  @override
  State<NotifiedPage> createState() => _NotifiedPageState();
}

class _NotifiedPageState extends State<NotifiedPage> {
  late String _fullName = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .get();
      setState(() {
        _fullName = userDoc['FullName'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    final String medicinename = widget.label.toString().split("|")[0];
    final String medicinedosage = widget.label.toString().split("|")[1];
    final String medicinehour = widget.label.toString().split("|")[2];
    final String medicinemin = widget.label.toString().split("|")[3];
    final String formattedMinute = medicinemin.padLeft(2, '0');
    final String medicinecolor = widget.label.toString().split("|")[4];
    final String medicinedate = DateFormat('yMMMMd').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 40),
            onPressed: () {
              Get.back();
            },
          ),
        ],
        title: const Text(
          mReminder,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Text(
              "Hello, $_fullName",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? darkColorScheme.primary
                      : lightColorScheme.primary),
            ),
            const SizedBox(height: 10),
            Text(
              "It's time to take $medicinedosage $medicinename",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 320,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final cardWidth =
                      constraints.maxWidth * 0.8; // 80% of the available width
                  final cardHeight = constraints.maxHeight * 0.6;

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      color: _getBGClr(medicinecolor),
                      child: Container(
                        width: cardWidth,
                        height: cardHeight,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Symbols.pill,
                                  size: 30,
                                  fill: 1,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  medicinename,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: _getACClr(medicinecolor)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    medicinedate,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  const SizedBox(height: 10),
                                  Text("$medicinehour:$formattedMinute",
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  const SizedBox(height: 10),
                                  Text(
                                    "$medicinedosage dosage",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: FilledButton(
                  onPressed: () {
                    _updateIsCompleted(medicinecolor);
                    Get.toNamed('/medicine_screen');
                  },
                  style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(60)),
                  child: const Text(mTake,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }
}

void _updateIsCompleted(String container) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Update the isCompleted field to 1
    await firestore
        .collection('MedicineReminder')
        .doc(container)
        .update({'isCompleted': 1});

    debugPrint('MedicineReminder updated successfully.');
  } catch (error) {
    debugPrint('Error updating MedicineReminder: $error');
  }
}

_getBGClr(String no) {
  switch (no) {
    case '1':
      return Colors.green;
    case '2':
      return Colors.red;
    case '3':
      return Colors.orange;
    case '4':
      return Colors.yellow;
    default:
      return const Color.fromARGB(255, 3, 64, 113);
  }
}

_getACClr(String no) {
  switch (no) {
    case '1':
      return const Color.fromARGB(255, 41, 116, 44);
    case '2':
      return Colors.redAccent;
    case '3':
      return Colors.orangeAccent;
    case '4':
      return Colors.yellowAccent;
    default:
      return const Color.fromARGB(255, 3, 64, 113);
  }
}
