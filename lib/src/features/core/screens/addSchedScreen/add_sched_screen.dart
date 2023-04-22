import 'package:flutter/material.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_appbar.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_med.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_sched.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/widgets/add_sched_card_time.dart';

class AddSched extends StatelessWidget {
  const AddSched({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddSchedAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AddSchedCard(),
              AddSchedCardTime(),
              AddSchedCardSched(),
            ],
          ),
        ),
      ),
    );
  }
}
