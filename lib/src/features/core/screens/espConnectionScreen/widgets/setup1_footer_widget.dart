import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class SetupDeviceFooter extends StatefulWidget {
  const SetupDeviceFooter({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<SetupDeviceFooter> createState() => _SetupDeviceFooterState();
}

class _SetupDeviceFooterState extends State<SetupDeviceFooter> {
  bool _isWifiEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkWifiStatus();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _checkWifiStatus();
    });
  }

  Future<void> _checkWifiStatus() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _isWifiEnabled = true;
      });
    } else {
      setState(() {
        _isWifiEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _isWifiEnabled
              ? () {
                  Get.toNamed('/signup');
                }
              : null,
          child: Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _isWifiEnabled
                    ? [Colors.cyan, Colors.blue]
                    : [Colors.grey, Colors.grey],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                mContinueSetup,
                style: TextStyle(
                  color: _isWifiEnabled ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            child: const Text(mNotYet),
            onPressed: () {
              Get.back();
            }),
      ],
    );
  }
}
