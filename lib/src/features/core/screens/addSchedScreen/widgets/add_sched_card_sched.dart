import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medic_ally/src/constants/app_constants.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_week_modal.dart';

class AddSchedCardSched extends StatefulWidget {
  const AddSchedCardSched({super.key});

  @override
  State<AddSchedCardSched> createState() => _AddSchedCardSchedState();
}

class _AddSchedCardSchedState extends State<AddSchedCardSched> {
  bool _isContinuous = true;
  bool _isSpecificDays = false;
  bool _isRemindEvery = false;
  bool _isVisible = true;

  String _startDate = DateFormat('MM/dd/yyyy').format(DateTime.now());
  int? _numberOfDays;
  TimeOfDay _reminderTime = TimeOfDay(hour: 8, minute: 0);
  List<bool> _daysSelected = List.generate(7, (index) => false);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedDate != null) {
      setState(() {
        _startDate = DateFormat('MM/dd/yyyy').format(selectedDate);
        print(_startDate);
      });
    } else {
      print("Error");
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (selectedTime != null) {
      setState(() {
        _reminderTime = selectedTime;
      });
    }
  }

  List<DateTime> _selectedDates = [];

  Future<void> _selectDays(BuildContext context) async {
    final List<bool>? result = await showModalBottomSheet<List<bool>>(
      context: context,
      builder: (BuildContext context) {
        return DaysOfWeekModal(daysSelected: _daysSelected);
      },
    );
    if (result != null) {
      setState(() {
        _daysSelected = result;
        if (_isSpecificDays) {
          _selectedDates = _getSelectedDates();
        }
      });
    }
  }

  List<DateTime> _getSelectedDates() {
    final List<DateTime> selectedDates = [];
    final DateTime startDate = DateFormat('MM/dd/yyyy').parse(_startDate);
    final int startWeekday = startDate.weekday;
    for (int i = 0; i < 7; i++) {
      if (_daysSelected[i]) {
        final DateTime date = startDate.add(Duration(days: i - startWeekday));
        selectedDates.add(date);
      }
    }
    return selectedDates;
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
            mSchedule,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                mStartDate,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () => _selectDate(context),
                child: Text(_startDate),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            mDays,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: _isSpecificDays,
                    onChanged: (bool? value) {
                      setState(() {
                        _isSpecificDays = value!;
                      });
                    },
                  ),
                  const Text(mEveryDay),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: _isSpecificDays,
                    onChanged: (bool? value) {
                      setState(() {
                        _isSpecificDays = value!;
                        if (_isSpecificDays) {
                          _selectDays(context);
                        }
                      });
                    },
                  ),
                  const Text(mSpecificDay),
                ],
              ),
              if (_isSpecificDays && _selectedDates.isNotEmpty)
                const SizedBox(height: 10),
              Visibility(
                visible: _isSpecificDays && _selectedDates.isNotEmpty,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _selectedDates.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DateFormat formatter = DateFormat('EEE');
                    return Text(formatter.format(_selectedDates[index]));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
