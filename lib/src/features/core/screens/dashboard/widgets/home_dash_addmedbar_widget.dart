import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class DashAddmed extends StatelessWidget {
  const DashAddmed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(DateFormat('EEEE').format(DateTime.now()),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500)),
            ],
          ),
          FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text(mAddMed))
        ],
      ),
    );
  }
}
