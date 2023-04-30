import 'package:flutter/material.dart';

class DaysOfWeekModal extends StatefulWidget {
  final List<bool> daysSelected;
  const DaysOfWeekModal({Key? key, required this.daysSelected})
      : super(key: key);

  @override
  _DaysOfWeekModalState createState() => _DaysOfWeekModalState();
}

class _DaysOfWeekModalState extends State<DaysOfWeekModal> {
  late List<bool> _daysSelected;

  @override
  void initState() {
    super.initState();
    _daysSelected = List.from(widget.daysSelected);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Select days of the week',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                final day = _getDayName(index);
                return CheckboxListTile(
                  title: Text(day),
                  value: _daysSelected[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _daysSelected[index] = value!;
                    });
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context, _daysSelected);
                },
                child: const Text('Save'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, null);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDayName(int index) {
    switch (index) {
      case 0:
        return 'Sunday';
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        return '';
    }
  }
}
