import 'package:flutter/material.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:provider/provider.dart';

class AddSchedCard extends StatefulWidget {
  const AddSchedCard({Key? key}) : super(key: key);

  @override
  _AddSchedCardState createState() => _AddSchedCardState();
}

class _AddSchedCardState extends State<AddSchedCard> {
  final TextEditingController medController = TextEditingController();
  MedLabel? selectedMed;
  int? selectedNumber;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<MedLabel>> medEntries =
        MedLabel.values.map((MedLabel med) {
      return DropdownMenuItem<MedLabel>(
        value: med,
        child: Text(med.med),
      );
    }).toList();

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
              mMedication,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Consumer<AddMedicineName>(builder: (context, medicine, child) {
              return DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: false,
                  labelText: 'Select Medication',
                ),
                value: medicine.medicineNames.isNotEmpty
                    ? medicine.medicineNames.first
                    : null,
                items: [
                  const DropdownMenuItem(
                    value: '',
                    child: Text('Select a medicine'),
                  ),
                  ...medicine.medicineNames.map(
                    (medicineName) {
                      return DropdownMenuItem(
                        value: medicineName,
                        child: Text(medicineName),
                      );
                    },
                  ),
                ],
                onChanged: (value) {},
              );
            }),
            const SizedBox(height: 20),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: false,
                labelText: 'Select Dosage',
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

enum MedLabel { paracetamol, opthamax, neozep, advil, fernC }

extension MedLabelExtension on MedLabel {
  String get med {
    switch (this) {
      case MedLabel.paracetamol:
        return 'Paracetamol';
      case MedLabel.opthamax:
        return 'Opthamax';
      case MedLabel.neozep:
        return 'Neozep';
      case MedLabel.advil:
        return 'Advil';
      case MedLabel.fernC:
        return 'Fern C';
    }
  }
}