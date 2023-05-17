import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:medic_ally/main.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/bottom_navbar.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'null',
        [
          NotificationChannel(
            channelKey: 'medically_channel',
            channelName: 'MedicAlly',
            channelDescription: 'Automated Medicine Dispenser',
            defaultColor: const Color(0xFF005DB6),
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true,
            criticalAlerts: true,
          )
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: "high_medically_channel_group",
            channelGroupName: "MedicAlly",
          ),
        ],
        debug: true);

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  // Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  // Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  // Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};

    if (payload["navigate"] == "true") {
      App.navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (_) => const BottomNavbar(),
      ));
    }
  }

  /*static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'MedicAlly',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }*/

  static void showNotification({
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
    required final String medName,
    required final String remTime,
    required final String startDate,
    required final String endDate,
  }) async {
    final currentTime = DateTime.now();
    final remTimeDate = DateTime.parse(remTime);
    final startDateDate = DateTime.parse(startDate);
    final endDateDate = DateTime.parse(endDate);

    // Check if the notification should be scheduled
    if (currentTime.isBefore(remTimeDate) &&
        currentTime.isAfter(startDateDate) &&
        currentTime.isBefore(endDateDate)) {
      // Calculate the time difference in milliseconds between the current time and the reminder time
      final timeDifference = remTimeDate.difference(currentTime).inMilliseconds;

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'medically_channel',
          title: 'MedicAlly',
          body: "Hello, it's time to take $medName.",
          payload: {
            'navigate': 'true',
          },
          actionType: actionType,
          notificationLayout: notificationLayout,
          summary: summary,
          category: category,
        ),
        schedule: NotificationInterval(
          interval: timeDifference,
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        ),
      );
    }
  }
}
