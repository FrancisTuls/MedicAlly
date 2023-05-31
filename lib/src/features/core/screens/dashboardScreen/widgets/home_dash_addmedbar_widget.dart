import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashAddmed extends StatelessWidget {
  const DashAddmed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Flexible(
            child: Text(
              DateFormat('EEEE').format(DateTime.now()),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
