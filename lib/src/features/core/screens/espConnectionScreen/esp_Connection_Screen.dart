import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/sizes_strings.dart';
import 'package:medic_ally/src/features/core/screens/espConnectionScreen/widgets/setup1_body_widget.dart';
import 'package:medic_ally/src/features/core/screens/espConnectionScreen/widgets/setup1_footer_widget.dart';
import 'package:medic_ally/src/features/core/screens/espConnectionScreen/widgets/setup1_header_widget.dart';

class EspConnection extends StatelessWidget {
  const EspConnection({super.key});

  @override
  Widget build(BuildContext context) {
    final shape = StadiumBorder();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 247, 247),
      body: Column(children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
              )),
            )),
        Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [SetupDeviceHeader(size: size)],
              )),
            )),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.all(35),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [SetupDeviceBody(size: size)],
            )),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(30),
              alignment: Alignment.center,
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [SetupDeviceFooter(size: size)],
              )),
            )),
      ]),
    );
  }
}
