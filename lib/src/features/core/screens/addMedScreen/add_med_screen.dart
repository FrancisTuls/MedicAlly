import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/controllers/medicine_reminder.dart';
import 'package:medic_ally/src/features/core/models/med_reminder.dart';
import 'package:medic_ally/src/features/core/screens/addMedScreen/widgets/add_med_appbar.dart';
import 'package:medic_ally/src/features/core/screens/addMedScreen/widgets/add_med_card.dart';
import 'package:medic_ally/src/features/core/screens/addMedScreen/widgets/add_med_card_dosage.dart';
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
  void initState() {
    super.initState();
    final medNameProvider =
        Provider.of<AddMedicineName>(context, listen: false);
    _medicineNameController.text = medNameProvider.medicineName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddMedAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddMedicineCard(
                title: 'What is the name of the medicine?',
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
                        'What container you want to store it?',
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
              FilledButton(
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
    final CollectionReference medReminderCollection =
        FirebaseFirestore.instance.collection('MedicineReminder');
    final selectedContainer =
        Provider.of<SelectedCircleProvider>(context, listen: false)
            .selectedCircle;
    final stock =
        Provider.of<AddMedicineStock>(context, listen: false).selectedNumber;

    final medReminder = MedReminder(
      id: selectedContainer,
      medName: _medicineNameController.text,
      stock: stock!,
      dosage: 0,
      remTime: DateFormat("h:mm a").format(DateTime.now()).toString(),
      startDate: DateFormat('MM/dd/yyyy').format(DateTime.now()).toString(),
      endDate: DateFormat('MM/dd/yyyy').format(DateTime.now()).toString(),
      isCompleted: 0,
    );
    medReminderCollection
        .doc(selectedContainer.toString())
        .set(medReminder.toJson());
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
                ? Colors.green
                : index == 2
                    ? Colors.red
                    : index == 3
                        ? Colors.orange
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
          ),
        );
      },
    );
  }
}
