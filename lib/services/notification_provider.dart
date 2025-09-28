import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initialize notification and timezone
  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Dhaka'));

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(initSettings);
  }

  /// Schedule Birthday Notification 2 days before and repeat every 12 hours
  static Future<void> scheduleBirthdayNotification({
    required int id,
    required String title,
    required String body,
    required DateTime birthday,
  }) async {
    final now = DateTime.now();
    final nextBirthday = DateTime(
      now.year,
      birthday.month,
      birthday.day,
    );

    tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      nextBirthday.subtract(const Duration(seconds: 10)).copyWith(hour: 0, minute: 0),
      tz.local,
    );

    const androidDetails = AndroidNotificationDetails(
      'birthday_channel',
      'Birthday Notifications',
      channelDescription: 'Reminder for birthdays',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    // 12 ঘণ্টার interval notification
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // yearly at same time
      payload: "birthday_reminder",
    );


    // Optional: 12-hour interval using periodic timer (workaround)
    // Flutter Local Notifications doesn't support exact 12-hour repeating directly
    // so you can schedule next 12-hour manually after first fires
  }

  /// Cancel single notification
  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// Cancel all notifications
  static Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }
}
