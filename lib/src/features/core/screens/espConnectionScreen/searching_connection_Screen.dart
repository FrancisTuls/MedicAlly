import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/sizes_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class SearchConnection extends StatelessWidget {
  const SearchConnection({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () => context.goNamed("device_connected_Screen"),
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: const Image(
                alignment: Alignment.center,
                image: AssetImage(mSetupDeviceSearching),
                width: 326,
                height: 327,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(35),
            child: Column(
              children: const [
                Text(
                  mSearch1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(230, 0, 0, 0)),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                Text(
                  mSearch1_1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Color.fromARGB(110, 0, 0, 0)),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Text(
                  mSearch1_2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Color.fromARGB(110, 0, 0, 0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
