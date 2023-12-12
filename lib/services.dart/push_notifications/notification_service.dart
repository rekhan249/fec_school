import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestForNotificationPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print(' authorized permission granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('provisional permission also granted');
    } else {
      print('permission not granted');
    }
  }
}
