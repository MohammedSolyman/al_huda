import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon

        'resource://drawable/mosque',
        /*android/app/src/main/res/drawable*/
        [
          NotificationChannel(
            channelGroupKey: 'basic_channel_group_key',
            channelKey: 'basic_channel_key',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true,
            criticalAlerts: true,
          )
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group_key',
              channelGroupName: 'Basic group')
        ],
        debug: true);

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((bool isAllowed) async {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: _onActionReceivedMethod,
        onNotificationCreatedMethod: _onNotificationCreatedMethod,
        onNotificationDisplayedMethod: _onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: _onDismissActionReceivedMethod);
  }

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> _onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod----------------------------');
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> _onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod----------------------------');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> _onDismissActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onDismissActionReceivedMethod----------------------------');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> _onActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('_onActionReceivedMethod----------------------------');
  }

// show notification everyday at 9 pm
  static Future<void> showPeriodicNotification() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel_key',
          actionType: ActionType.Default,
          title: 'Al Huda',
          body: 'Did you read Quran today?',
          notificationLayout: NotificationLayout.Default,
          payload: {'navigate': 'true'},
        ),
        schedule: NotificationCalendar(
            //  second: 0,
            hour: 21,
            timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
            repeats: true));
  }

  static Future<void> cancelAll() async {
    //Cancels all active notifications and schedules.
    await AwesomeNotifications().cancelAll();
  }
}
