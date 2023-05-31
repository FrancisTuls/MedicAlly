import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';
import 'package:medic_ally/src/features/authentication/screens/notifiedScreen/notified_page_screen.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/bottom_navbar.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    _configureLocalTimezone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  //No Schedule Notification
  void displayNotification(
      {required String title, required String body}) async {
    debugPrint("doing test");

    //Android
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  //Calling the displayNotification Function
  /*NotificationService.displayNotification(
    title: "MedicAlly";
    body: "Hello, it's time to take $medName";
  );*/

  //Scheduled Notification
  Future<void> scheduledNotification(int hour, int minutes, int container,
      String medicine, String dosage, int stock) async {
    final notificationService = NotificationService();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        container,
        "Hello, it's time to take $medicine",
        'Take $dosage',
        _convertTime(hour, minutes),
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: newTime)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'MedicAlly Reminders',
          'MedicAlly',
          channelDescription: 'A Medication Reminder Ally',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        )),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "$medicine|$dosage|$hour|$minutes|$container|$stock");
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  void requestAndroidPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      // Perform deduction of stock based on the payload information
      // Example: Extract medicine and dosage from payload
      final List<String> data = payload!.split("|");
      final String stock = data[5];
      final String dosage = data[1];
      final String container = data[4];

      // Call the function to deduct the stock
      _deductStock(stock, dosage, container);
    } else {
      debugPrint('Notification Done');
    }
    Get.to(() => NotifiedPage(label: payload));
  }

  Future<void> _deductStock(
      String stock, String dosage, String container) async {
    try {
      int currentStock = int.parse(stock);
      int dosageCount = int.parse(dosage);
      //int containerNum = int.parse(container);

      if (currentStock >= dosageCount) {
        int updatedStock = currentStock - dosageCount;

        await FirebaseFirestore.instance
            .collection('MedicineReminder')
            .doc(container)
            .update({'stock': updatedStock});
      } else {
        // Stock is insufficient, handle the case accordingly (e.g., show an error message)

        Get.snackbar(
          'Stock is Low',
          'Refill the stock in Container $container',
          icon: const Icon(Icons.error_rounded),
          backgroundColor: lightColorScheme.tertiaryContainer,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (error) {
      // Handle any potential errors during stock deduction
      debugPrint('Error deducting stock: $error');
    }
  }

  static showRefillNotification() async {
    final notificationService = NotificationService();
    // Display a non-scheduled notification for stock refill
    const String notificationTitle = 'Stock Refill';
    const String notificationBody = 'It\'s time to refill the medicine stock.';

    // Create notification details
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'MedicAlly Notifications',
      'MedicAlly',
      channelDescription: 'A Medication Reminder Ally',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    // Display the notification
    await notificationService.flutterLocalNotificationsPlugin.show(
      0,
      notificationTitle,
      notificationBody,
      notificationDetails,
    );
  }
}
