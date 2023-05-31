import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';
import 'package:provider/provider.dart';

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
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.only(top: 10, bottom: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: isDarkMode
              ? lightColorScheme.inverseSurface
              : const Color(0xFFEAF0FA)),
      child: CalendarTimeline(
        showYears: false,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
        onDateSelected: (date) =>
            context.read<DateProvider>().setSelectedDate(date),
        leftMargin: 20,
        monthColor: isDarkMode ? Colors.white : Colors.black,
        dayColor: isDarkMode ? const Color(0xFF006875) : Color(0xFF004F58),
        dayNameColor: isDarkMode ? Colors.black : Colors.white,
        activeDayColor: isDarkMode ? Colors.black : Colors.white,
        activeBackgroundDayColor:
            isDarkMode ? darkColorScheme.primary : lightColorScheme.primary,
        dotsColor: isDarkMode ? Colors.black : Colors.white,
        locale: 'en',
      ),
    );
  }
}
