import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medic_ally/services/notification_services.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/add_med_floating_button.dart';
import 'package:medic_ally/src/features/core/screens/medicineScreen/widgets/low_stock_widget.dart';
import 'package:medic_ally/src/features/core/screens/medicineScreen/widgets/medicine_appbar.dart';
import 'package:medic_ally/src/features/core/screens/medicineScreen/widgets/medicine_card.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({super.key});

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  List<DocumentSnapshot> docs = [];
  bool showLowStockMessage = false;
  List<String> lowStockContainers = [];

  Future<void> checkStockAndNotify() async {
    bool showRefillNotification = false;
    List<String> updatedLowStockContainers = [];
    //lowStockContainers.clear();

    for (final doc in docs) {
      final stock = doc.exists ? (doc.get('stock') ?? 0) as int : 0;
      final container = doc.get('id') ?? '';

      if (stock < 7) {
        showRefillNotification = true;
        updatedLowStockContainers.add(container.toString());
      }
    }

    debugPrint("Low stock containers: $lowStockContainers");
    debugPrint("Show refill notification: $showRefillNotification");

    if (showRefillNotification) {
      NotificationService.showRefillNotification();
    }

    setState(() {
      showLowStockMessage = updatedLowStockContainers.isNotEmpty;
      lowStockContainers = updatedLowStockContainers;
    });

    // Show the low stock warning widget with the list of low stock containers
    /*if (lowStockContainers.isNotEmpty) {
      // Use lowStockContainers to display the list of containers with low stock
      // Example: Display a SnackBar with the container IDs

      Get.snackbar(
        'Stock is Low',
        "Refill the stock in containers: ${lowStockContainers.join(', ')}",
        icon: const Icon(Icons.error_rounded),
        backgroundColor: lightColorScheme.tertiaryContainer,
        snackPosition: SnackPosition.BOTTOM,
      );
    }*/
  }

  Future<List<DocumentSnapshot>> fetchMedicineReminders() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('MedicineReminder').get();
    final List<DocumentSnapshot> documents = querySnapshot.docs;

    return documents;
  }

  @override
  void initState() {
    super.initState();
    fetchMedicineReminders().then((data) {
      setState(() {
        docs = data;
        checkStockAndNotify();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MedicineAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MedicineStockCard(),
              if (showLowStockMessage) ...[
                const SizedBox(height: 16),
                LowStockMessage(lowStockContainers: lowStockContainers),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: const AddMedFloating(),
    );
  }
}
