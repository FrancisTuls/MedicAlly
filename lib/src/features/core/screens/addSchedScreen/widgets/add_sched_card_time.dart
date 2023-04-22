import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medic_ally/src/constants/app_constants.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class AddSchedCardTime extends StatefulWidget {
  const AddSchedCardTime({super.key});

  @override
  State<AddSchedCardTime> createState() => _AddSchedCardTimeState();
}

class _AddSchedCardTimeState extends State<AddSchedCardTime> {
  String _selectedWhen = 'AM';
  String _selectedFreq = 'x times a day';
  TimeOfDay _selectedTime = TimeOfDay(hour: 8, minute: 0);

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _reminderTimes[index],
    );
    if (pickedTime != null) {
      setState(() {
        _reminderTimes[index] = pickedTime;
      });
    }
  }

  void updateIntervalField(bool value) {
    setState(() {
      AppConstants.showIntervalField = value;
    });
  }

  Widget _buildReminderChips() {
    return Wrap(
      spacing: 8,
      children: List.generate(
        _reminderTimes.length,
        (index) => InputChip(
          label: Text(
            DateFormat.jm().format(
              DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                _reminderTimes[index].hour,
                _reminderTimes[index].minute,
              ),
            ),
          ),
          onDeleted: () {
            setState(() {
              _reminderTimes.removeAt(index);
            });
          },
          onPressed: () => _selectTime(context, index),
        ),
      ),
    );
  }

  List<TimeOfDay> _reminderTimes = [TimeOfDay(hour: 8, minute: 0)];
  final List<String> _frequencyOptions = [
    'x times a day',
    'every x hours',
  ];

  final List<String> _whenOptions = [
    'AM',
    'PM',
  ];

  List<String> _selectedTimes = ['8:00 AM'];

  void _addReminderTime() {
    setState(() {
      _selectedTimes.add('12:00 PM'); // add a new reminder time
    });
  }

  void _removeReminderTime(int index) {
    setState(() {
      _selectedTimes.removeAt(index); // remove the reminder time at the index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              mTime,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: _selectedWhen,
              isExpanded: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "When to Take"),
              onChanged: (value) {
                setState(() {
                  _selectedWhen = value!;
                });
              },
              items: ['AM', 'PM']
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: _selectedFreq,
              isExpanded: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: false,
                labelText: "Frequency",
              ),
              onChanged: (value) {
                setState(() {
                  _selectedFreq = value!;
                  if (value == 'every x hours') {
                    AppConstants.showIntervalField = false;
                  } else {
                    AppConstants.showIntervalField = true;
                  }
                });
              },
              items: [
                'x times a day',
                'every x hours',
              ]
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: AppConstants.showIntervalField,
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _reminderTimes.add(TimeOfDay.now());
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Reminder Time'),
              ),
            ),
            const SizedBox(height: 8),
            Visibility(
                visible: AppConstants.showIntervalField,
                child: _buildReminderChips()),

            /*OutlinedButton.icon(
              onPressed: _addReminderTime,
              icon: const Icon(Icons.add),
              label: const Text(mAddRemTime),
            ),*/
            /*const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: _selectedTimes.asMap().entries.map((entry) {
                final index = entry.key;
                final time = entry.value;

                return InputChip(
                  label: Text(time),
                  onDeleted: () => _removeReminderTime(index),
                );
              }).toList(),
            ),*/
          ],
        ),
      ),
    );
  }
}
