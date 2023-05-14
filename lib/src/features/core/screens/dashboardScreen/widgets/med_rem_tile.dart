import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(container),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medName,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.black,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "$remTime - $date",
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  dosage,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.black,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              completed == '1' ? "COMPLETED" : "NEXT",
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.green;
      default:
        return Color.fromARGB(255, 3, 64, 113);
    }
  }
}
