import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:medic_ally/src/constants/app_constants.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_week_modal.dart';
import 'package:provider/provider.dart';

class AddSchedCardSched extends StatefulWidget {
  const AddSchedCardSched({super.key});

  @override
  State<AddSchedCardSched> createState() => _AddSchedCardSchedState();
}

class _AddSchedCardSchedState extends State<AddSchedCardSched> {
  /*bool _isContinuous = true;
  bool _isSpecificDays = false;
  bool _isRemindEvery = false;
  bool _isVisible = true;*/

  String? _time;

  String _startDate = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String _endDate = DateFormat('MM/dd/yyyy').format(DateTime.now());
  //int? _numberOfDays;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 8, minute: 0);
  //List<bool> _daysSelected = List.generate(7, (index) => false);

  Future<void> _selectDate(BuildContext context) async {
    final selectedDateProvider =
        Provider.of<SelectedDateProvider>(context, listen: false);

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedDate != null) {
      setState(() {
        _startDate = DateFormat('MM/dd/yyyy').format(selectedDate);
        selectedDateProvider.selectedDate = selectedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final selectedEndDateProvider =
        Provider.of<SelectedEndDateProvider>(context, listen: false);

    final DateTime? selectedEndDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedEndDate != null) {
      setState(() {
        _endDate = DateFormat('MM/dd/yyyy').format(selectedEndDate);
        selectedEndDateProvider.selectedEndDate = selectedEndDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final selectedTimeProvider =
        Provider.of<SelectedTimeProvider>(context, listen: false);
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (selectedTime != null) {
      setState(() {
        _reminderTime = selectedTime;
        String period = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';
        String formattedMinute = selectedTime.minute.toString().padLeft(2, '0');
        _time = '${selectedTime.hourOfPeriod}:$formattedMinute $period';
        selectedTimeProvider.selectedTime = _time.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'When are you going to take the medicine?',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Time: ',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              OutlinedButton.icon(
                onPressed: () => _selectTime(context),
                label: Text(_reminderTime.format(context)),
                icon: const Icon(Icons.schedule, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    mStartDate,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _selectDate(context),
                    label: Text(_startDate),
                    icon: const Icon(Icons.today, size: 20),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    mEndDate,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _selectEndDate(context),
                    label: Text(_endDate),
                    icon: const Icon(Icons.event, size: 20),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
