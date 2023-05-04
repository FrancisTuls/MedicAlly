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
  String _startHour = DateFormat("h:mm a").format(DateTime.now()).toString();

  int _selectRemindEvery = 13;

  List<int> remindEveryList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

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
      AppConstants.showReminderTime = value;
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

  Widget _buildRemindEvery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              mRemindevery,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 10),
            DropdownButton(
              items: remindEveryList.map<DropdownMenuItem<String>>((int value) {
                return DropdownMenuItem<String>(
                  value: value.toString(),
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectRemindEvery = int.parse(newValue!);
                });
              },
              hint: Text(
                "$_selectRemindEvery hours",
                style: const TextStyle(color: Color(0xFF005DB6)),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Text(
              mStartHour,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () {
                _getStartHourFromUser(isStartHour: true);
              },
              child: Text(_startHour),
            ),
          ],
        ),
      ],
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
                    AppConstants.showReminderTime = false;
                    AppConstants.showRemindEvery = true;
                  } else {
                    AppConstants.showReminderTime = true;
                    AppConstants.showRemindEvery = false;
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
              visible: AppConstants.showReminderTime,
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
                visible: AppConstants.showReminderTime,
                child: _buildReminderChips()),
            Visibility(
                visible: AppConstants.showRemindEvery,
                child: _buildRemindEvery())

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

  _getStartHourFromUser({required bool isStartHour}) async {
    var selectedStartHour = await _showTimePicker();
    String _formattedTime = selectedStartHour.format(context);
    if (selectedStartHour == null) {
      print("Cancelled");
    } else if (isStartHour == true) {
      setState(() {
        _startHour = _formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.dial,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startHour.split(":")[0]),
            minute: int.parse(_startHour.split(":")[1].split(" ")[0])));
  }
}
