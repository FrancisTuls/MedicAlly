import 'package:flutter/material.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:provider/provider.dart';

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
        List.generate(20, (index) {
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
              'How many medicines you want to store?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Consumer<AddMedicineStock>(
              builder: (context, stock, _) => DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: false,
                  labelText: 'Select Stock',
                ),
                value: stock.selectedNumber,
                onChanged: (int? number) {
                  stock.selectedNumber = number;
                },
                items: numberEntries,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
