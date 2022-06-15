import 'package:dyeac/api/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String>();

  static Future _notificationDetail() async {
    final largeIconPath = await Utils.downloadFile(
      'https://firebasestorage.googleapis.com/v0/b/dyeac-8fc86.appspot.com/o/assets%2Feye-drops.png?alt=media&token=49531939-79ee-40af-a4f9-ed66ff6dc524',
      'largeIcon',
    );

    final bigPicturePath = await Utils.downloadFile(
      'https://firebasestorage.googleapis.com/v0/b/dyeac-8fc86.appspot.com/o/assets%2Feye-drops.png?alt=media&token=49531939-79ee-40af-a4f9-ed66ff6dc524',
      'bigPicture',
    );

    final StyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: '',
        importance: Importance.max,
        styleInformation: StyleInformation,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initSchedule = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final setting = InitializationSettings(android: android, iOS: iOS);

    //when app is close
    // final details = await _notification.getNotificationAppLaunchDetails();
    // if (details != null && details.didNotificationLaunchApp) {
    //   onNotification.add(details.payload);
    // }

    await _notification.initialize(
      setting,
      onSelectNotification: (payload) async {
        onNotification.add(payload);
      },
    );

    if (initSchedule) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification({
    int id = 0,
    String title,
    String body,
    String payload,
  }) async =>
      _notification.show(
        id,
        title,
        body,
        await _notificationDetail(),
        payload: payload,
      );

  static void showScheduleNotification({
    int id = 0,
    String title,
    String body,
    String payload,
    DateTime scheduleDate,
  }) async =>
      _notification.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduleDate, tz.local),
        await _notificationDetail(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
}
