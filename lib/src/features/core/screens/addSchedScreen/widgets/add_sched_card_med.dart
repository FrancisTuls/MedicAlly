import 'package:flutter/material.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:provider/provider.dart';

class AddSchedCard extends StatefulWidget {
  const AddSchedCard({Key? key}) : super(key: key);

  @override
  _AddSchedCardState createState() => _AddSchedCardState();
}

class _AddSchedCardState extends State<AddSchedCard> {
  final TextEditingController medController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ListMedicineNames>(context, listen: false).fetchMedicineNames();
  }

  int? selectedNumber;

  @override
  Widget build(BuildContext context) {
    final numberProvider = Provider.of<SelectedDosage>(context);

    final List<DropdownMenuItem<int>> numberEntries = List.generate(5, (index) {
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
              'How many medicines you want to take?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Consumer<ListMedicineNames>(builder: (context, medicine, child) {
              return DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: false,
                  labelText: 'Select Medication',
                ),
                //Manual values
                /*value: medicine.medicineNames.isNotEmpty
                    ? medicine.medicineNames.first
                    : null,*/

                //Database values
                value: medicine.selectedMedicine,
                items: [
                  const DropdownMenuItem(
                    value: '',
                    child: Text('Select a Medicine'),
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
                onChanged: (value) {
                  Provider.of<ListMedicineNames>(context, listen: false)
                      .setSelectedMedicine(value);
                  int selectedIndex =
                      medicine.medicineNames.indexOf(value.toString());
                  Provider.of<SelectedCircleProvider>(context, listen: false)
                      .selectedCircle = selectedIndex + 1;
                },
              );
            }),
            const SizedBox(height: 20),
            Consumer<SelectedDosage>(
              builder: (context, dosage, _) => DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: false,
                  labelText: 'Select Dosage',
                ),
                value: numberProvider.selectedNumber,
                onChanged: (int? number) {
                  numberProvider.selectedNumber = number;
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
