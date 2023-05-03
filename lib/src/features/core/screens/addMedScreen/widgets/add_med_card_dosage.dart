import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class AddMedicineCardStock extends StatefulWidget {
  const AddMedicineCardStock({super.key});

  @override
  State<AddMedicineCardStock> createState() => _AddMedicineCardStockState();
}

class _AddMedicineCardStockState extends State<AddMedicineCardStock> {
  int? selectedNumber;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<int>> numberEntries =
        List.generate(25, (index) {
      return DropdownMenuItem<int>(
        value: index + 1,
        child: Text((index + 1).toString()),
      );
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              mStock,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: false,
                labelText: 'Select Stock',
              ),
              value: selectedNumber,
              onChanged: (int? number) {
                setState(() {
                  selectedNumber = number;
                });
              },
              items: numberEntries,
            ),
          ],
        ),
      ),
    );
  }
}