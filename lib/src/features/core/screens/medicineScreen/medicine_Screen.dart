import 'package:flutter/material.dart';
import 'package:medic_ally/src/features/core/screens/medicineScreen/widgets/medicine_appbar.dart';
import 'package:medic_ally/src/features/core/screens/medicineScreen/widgets/medicine_card.dart';
import 'package:medic_ally/src/features/core/screens/medicineScreen/widgets/medicine_label_fields.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MedicineAppBar(),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MedicineStockCard(),
          ],
        ),
      )),
    );
  }
}
