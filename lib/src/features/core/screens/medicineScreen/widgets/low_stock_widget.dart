import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';

class LowStockMessage extends StatelessWidget {
  final List<String> lowStockContainers;

  const LowStockMessage({Key? key, required this.lowStockContainers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.redAccent,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.error_rounded),
                SizedBox(width: 10),
                Text(
                  'Stock is Low',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 34),
                Text(
                  "Refill stock in containers: ${lowStockContainers.join(', ')}",
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
          ],
        ),
      ),
    );

    /*Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lightColorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_rounded),
          const SizedBox(width: 8),
          Text(
            'Stock is Low.',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );*/
  }
}
