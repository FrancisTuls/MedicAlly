import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class MedTile extends StatelessWidget {
  final String medName;
  final String remTime;
  final String completed;
  final int container;
  final String date;
  final String dosage;

  const MedTile({
    super.key,
    required this.medName,
    required this.remTime,
    required this.completed,
    required this.container,
    required this.date,
    required this.dosage,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: isDarkMode
              ? darkColorScheme.primaryContainer
              : lightColorScheme.primaryContainer,
        ),
        child: Row(children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  _getBGClr(container), // Choose your desired background color
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  mContainer,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                RotatedBox(
                  quarterTurns: 4,
                  child: Text(
                    "$container",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medName,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Dosage:  $dosage',
                      style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: isDarkMode ? Colors.white : Colors.black,
                      size: 15,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      remTime,
                      style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              completed == '1' && date == getCurrentDate() ? "TAKEN" : "",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.yellow;
      default:
        return const Color.fromARGB(255, 3, 64, 113);
    }
  }

  String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('M/dd/yyyy');
    debugPrint(formatter.format(now));
    return formatter.format(now);
  }
}
