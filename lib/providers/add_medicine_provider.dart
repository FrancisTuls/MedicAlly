import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMedicineName extends ChangeNotifier {
  List<String> _medicineNames = [];

  List<String> get medicineNames => _medicineNames;

  void addMedicineName(String medicineName) {
    _medicineNames.add(medicineName);
    notifyListeners();
  }
}

class ListMedicineNames extends ChangeNotifier {
  List<String> _medicineNames = [];
  List<String> _containerNum = [];
  String? _selectedMedicine;

  List<String> get medicineNames => _medicineNames;
  String? get selectedMedicine => _selectedMedicine;

  Future<void> fetchMedicineNames() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('MedicineDetails').get();
    final medicineNames =
        snapshot.docs.map((doc) => doc.data()['medName'] as String).toList();
    _medicineNames = medicineNames;
    notifyListeners();
  }

  Future<void> fetchContainer() async {
    final snapshotContainer =
        await FirebaseFirestore.instance.collection('MedicineDetails').get();
    final containerNum = snapshotContainer.docs
        .map((doc) => doc.data()['container'] as String)
        .toList();
    _containerNum = containerNum;
  }

  void setSelectedMedicine(String? value) {
    _selectedMedicine = value;
    notifyListeners();
  }
}

class AddMedicineStock extends ChangeNotifier {
  int? _selectedNumber;

  int? get selectedNumber => _selectedNumber;

  set selectedNumber(int? value) {
    _selectedNumber = value;
    notifyListeners();
  }
}

class SelectedCircleProvider with ChangeNotifier {
  int _selectedCircle = -1;

  int get selectedCircle => _selectedCircle;

  set selectedCircle(int selectedCircle) {
    _selectedCircle = selectedCircle;
    notifyListeners();
  }
}

class SelectedDosage extends ChangeNotifier {
  int? _selectedDosage;

  int? get selectedNumber => _selectedDosage;

  set selectedNumber(int? number) {
    _selectedDosage = number;
    notifyListeners();
  }
}

class SelectedTimeProvider with ChangeNotifier {
  String _selectedTime = "8:00 AM";

  String get selectedTime => _selectedTime;

  set selectedTime(String selectedTime) {
    _selectedTime = selectedTime;
    notifyListeners();
    //TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);

    //TimeOfDay get selectedTime => _selectedTime;

    /*set selectedTime(TimeOfDay selectedTime) {
    _selectedTime = selectedTime;
    notifyListeners();*/
  }
}

class SelectedDateProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }
}
