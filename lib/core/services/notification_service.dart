import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings('app_icon'),
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'event_channel',
          'Event Notifications',
          importance: Importance.max,
        ),
      ),
    );
  }

  static Future<void> scheduleNotification(DateTime eventDate, String eventTitle) async {
    dynamic scheduledTime = eventDate.subtract(Duration(hours: 1)); // 1 hour before
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Upcoming Event: $eventTitle',
      'Event is coming up in 1 hour!',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'event_channel',
          'Event Notifications',
          importance: Importance.max,
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, androidScheduleMode: AndroidScheduleMode.exact,

    );
  }
}
