import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/controllers/medicine_reminder.dart';
import 'package:medic_ally/src/features/core/models/med_details.dart';
import 'package:medic_ally/src/features/core/models/med_reminder.dart';
import 'package:medic_ally/src/features/core/screens/addMedScreen/widgets/add_med_appbar.dart';
import 'package:medic_ally/src/features/core/screens/addMedScreen/widgets/add_med_card.dart';
import 'package:medic_ally/src/features/core/screens/addMedScreen/widgets/add_med_card_dosage.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/add_sched_screen.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/add_medicine_provider.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final MedReminderController _medRemController =
      Get.put(MedReminderController());

  int _selectedCircle = -1;

  final TextEditingController _medicineNameController = TextEditingController();
  void _selectCircle(int index) {
    setState(() {
      _selectedCircle = index;
    });
  }

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

    return Scaffold(
      appBar: const AddMedAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddMedicineCard(
                title: mMedication,
                textFieldLabel: mMedicationName,
                controllername: _medicineNameController,
              ),
              const SizedBox(height: 10),
              const AddMedicineCardStock(),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        mContainer,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCircleAvatar(1),
                          _buildCircleAvatar(2),
                          _buildCircleAvatar(3),
                          _buildCircleAvatar(4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.tonal(
                onPressed: () {
                  _validateMedicineName();
                },
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                child: const Text(mNext,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateMedicineName() {
    if (_medicineNameController.text.isNotEmpty) {
      _addMedDetailsToDB();
      final medicineName = _medicineNameController.text;

      Provider.of<AddMedicineName>(context, listen: false)
          .addMedicineName(medicineName);
      Get.toNamed('/addsched');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Input all fields.'),
          action: SnackBarAction(
            label: 'Required',
            onPressed: () {
              // Code to execute.
            },
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  _addMedDetailsToDB() {
    final CollectionReference medDetailsCollection =
        FirebaseFirestore.instance.collection('MedicineDetails');
    final selectedContainer =
        Provider.of<SelectedCircleProvider>(context, listen: false)
            .selectedCircle;
    final stock =
        Provider.of<AddMedicineStock>(context, listen: false).selectedNumber;

    final medDetails = MedDetails(
      medName: _medicineNameController.text,
      stock: stock!,
      container: selectedContainer,
    );
    medDetailsCollection
        .doc(selectedContainer.toString())
        .set(medDetails.toJson());
  }

  Widget _buildCircleAvatar(int index) {
    return Consumer<SelectedCircleProvider>(
      builder: (context, container, _) {
        bool isSelected = container.selectedCircle == index;

        return GestureDetector(
          onTap: () {
            container.selectedCircle = index;
          },
          child: CircleAvatar(
            backgroundColor: index == 1
                ? Colors.red
                : index == 2
                    ? Colors.orange
                    : index == 3
                        ? Colors.yellow
                        : index == 4
                            ? Colors.green
                            : null,
            child: isSelected
                ? const Icon(Icons.check)
                : Text(
                    index.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
          ),
        );
      },
    );
  }
}

  /*Widget _buildCircleAvatar(int index) {
    final selectedCircleProvider = Provider.of<SelectedCircleProvider>(context);
    bool saveSelected = selectedCircleProvider.selectedCircle == index;
    bool isSelected = _selectedCircle == index;

    return GestureDetector(
        onTap: () => _selectCircle(index),
        child: CircleAvatar(
          backgroundColor: index == 1
              ? Colors.red
              : index == 2
                  ? Colors.blue
                  : index == 3
                      ? Colors.green
                      : index == 4
                          ? Colors.yellow
                          : null,
          child: isSelected
              ? const Icon(Icons.check)
              : Text(
                  index.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
        ));
  }
}*/
