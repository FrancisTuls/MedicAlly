import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class AddMedicineCard extends StatelessWidget {
  final String title;
  final String textFieldLabel;
  final TextEditingController controllername;

  const AddMedicineCard({
    Key? key,
    required this.title,
    required this.textFieldLabel,
    required this.controllername,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controllername,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                filled: false,
                labelText: textFieldLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
