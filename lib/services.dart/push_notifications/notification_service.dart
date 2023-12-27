// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'dart:io';
import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/providers/notices_provider.dart';
import 'package:fec_app2/screen_pages/notice_title.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class PushNotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

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
      if (kDebugMode) {
        print('authorized permission granted');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('provisional permission also granted');
      }
    } else {
      if (kDebugMode) {
        print('permission not granted');
      }
    }
  }

  Future<void> initializationNotifications(
      BuildContext context, RemoteMessage notificationMessage) async {
    tz.initializeTimeZones();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payLoad) async {
      messagesHandling(context, notificationMessage);
    });
  }

  void notificationInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((notificationMessage) {
      String? titleValue = notificationMessage.notification!.title.toString();
      String? bodyValue = notificationMessage.notification!.body.toString();
      if (kDebugMode) {
        print(titleValue);
        print(bodyValue);
        print(notificationMessage.data['mtype'].toString());
        print(notificationMessage.data['mid'].toString());
      }
      if (Platform.isAndroid) {
        initializationNotifications(context, notificationMessage);
      }
      showNotification(title: titleValue, body: bodyValue);
    });
  }

  Future<String> getDeviceToken() async {
    String? tokenValue = await messaging.getToken();

    return tokenValue!;
  }

  void getDeviceTokenRefreshing() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  Future<void> setUpMessageInteraction(BuildContext context) async {
    /// When App is in terminated state
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      messagesHandling(context, initialMessage);
    }
    FirebaseMessaging.onMessage.listen((onMessageNotifyMe) {
      messagesHandling(context, onMessageNotifyMe);
    });

    /// When is in bacground state
    FirebaseMessaging.onMessageOpenedApp.listen((onMessageOpenedAppNotifyMe) {
      messagesHandling(context, onMessageOpenedAppNotifyMe);
    });
  }

  void messagesHandling(BuildContext context, RemoteMessage? message) async {
    List<Notice> noticesList = await ApiService().getUsers();

    await Future.delayed(const Duration(seconds: 5)).whenComplete(() {
      for (int i = 0; i < noticesList.length; i++) {
        if (noticesList[i].id.toString() == message!.data['mid'] &&
            message.data['mtype'].toString() == "notice") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoticeTitle(
                        id: noticesList[i].id,
                        noticeValue: noticesList[i],
                        mid: message.data['mid'],
                        mtype: message.data['mtype'],
                      )));
        }
      }
    });
  }

  Future<void> showNotification(
      {required String title, required String body}) async {
    AndroidNotificationChannel androidNotificationChannel =
        const AndroidNotificationChannel(
            'high_importance_channel', 'Highly important notifications',
            importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(androidNotificationChannel.id.toString(),
            androidNotificationChannel.name.toString(),
            channelDescription: 'Fec school App channel name',
            importance: Importance.max,
            priority: Priority.high);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0, title, body, notificationDetails);
    });
  }
}
