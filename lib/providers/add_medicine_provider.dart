import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMedicineName extends ChangeNotifier {
  List<String> _medicineNames = [];

  List<String> get medicineNames => _medicineNames;

  void addMedicineName(String medicineName) {
    _medicineNames.add(medicineName);
    notifyListeners();
  }
}
