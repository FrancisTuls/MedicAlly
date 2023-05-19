import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDarkMode
                ? darkColorScheme.primaryContainer
                : lightColorScheme.primaryContainer,
            border: Border.all(color: _getBGClr(container), width: 3)),
        child: Row(children: [
          Column(
            children: [
              Text(
                mContainer,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 10),
              ),
              RotatedBox(
                quarterTurns: 4,
                child: Text(
                  "$container",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 60,
            width: 0.5,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 5),
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
              completed == '1' ? "TAKEN" : "",
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
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      default:
        return Color.fromARGB(255, 3, 64, 113);
    }
  }
}
