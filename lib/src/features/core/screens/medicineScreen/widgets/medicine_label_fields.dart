import 'package:flutter/material.dart';

class MedicineLabelFields extends StatelessWidget {
  const MedicineLabelFields(
      {required this.medName, required this.medStock, super.key});

  final String medName, medStock;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isDarkMode ? Colors.blueGrey : Colors.white,
              ),
              child: Row(
                children: [
                  Text(
                    medName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isDarkMode ? Colors.blueGrey : Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    medStock,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }
}
