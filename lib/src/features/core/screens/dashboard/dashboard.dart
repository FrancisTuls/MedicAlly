import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/features/core/screens/dashboard/widgets/bottom_navbar.dart';
import 'package:medic_ally/src/features/core/screens/dashboard/widgets/home_dash_addmedbar_widget.dart';
import 'package:medic_ally/src/features/core/screens/dashboard/widgets/home_dash_appbar_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

import 'widgets/home_dash_calendar_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 2));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: const DashAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            DashAddmed(),
            CalendarContainer(),
          ],
        ),
      ),
    );
  }
}
