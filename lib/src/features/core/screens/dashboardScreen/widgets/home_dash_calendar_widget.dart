import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class CalendarContainer extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CalendarContainer({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  _CalendarContainerState createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: CalendarTimeline(
        showYears: false,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
        onDateSelected: (date) => setState(() => _selectedDate = date),
        leftMargin: 20,
        monthColor: isDarkMode ? Colors.white : Colors.black,
        dayColor: isDarkMode
            ? const Color.fromRGBO(2, 157, 165, 1)
            : const Color.fromRGBO(137, 221, 226, 1),
        dayNameColor: Colors.white,
        activeDayColor: Colors.white,
        activeBackgroundDayColor:
            isDarkMode ? const Color(0xFF003063) : const Color(0xFF005DB6),
        dotsColor: const Color(0xFFF1F0F4),
        locale: 'en',
      ),
    );
  }
}
