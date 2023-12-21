import 'package:fec_app2/models/events_model.dart';
import 'package:fec_app2/screen_pages/events.dart';
import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class EventTitle extends StatefulWidget {
  final Event eventsValue;
  const EventTitle({super.key, required this.eventsValue});

  @override
  State<EventTitle> createState() => _EventTitleState();
}

String removeHtmlTags(String htmlString) {
  var document = parse(htmlString);
  String parsedString = parse(document.body!.text).documentElement!.text;
  return parsedString;
}

class _EventTitleState extends State<EventTitle> {
  final PushNotificationServices _pushNotificationServices =
      PushNotificationServices();

  @override
  void initState() {
    _pushNotificationServices.requestForNotificationPermissions();
    _pushNotificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('===========> \n $value');
      }
    });
    _pushNotificationServices.notificationInit(context);
    _pushNotificationServices.getDeviceTokenRefreshing();
    _pushNotificationServices.setUpMessageInteraction(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 25, 74, 159),
          leading: IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, EventScreen.routeName);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          title: ListTile(
            title: Text(
              widget.eventsValue.title.toString(),
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            subtitle: Text(
              DateFormat('dd-MM-yyyy--HH:mm')
                  .format(widget.eventsValue.createdAt!)
                  .toString(),
              style: TextStyle(color: Colors.white, fontSize: 10.sp),
            ),
          ),
          actions: [
            Container(
                width: 70.w,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Image.asset('assets/images/feclogos.png'))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            ClipPath(
              clipper: StraightBorderClipper(borderWidth: 0),
              child: Container(
                height: 10.h,
                width: double.infinity.w,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                      removeHtmlTags(widget.eventsValue.description.toString()),
                      style: TextStyle(fontSize: 15.sp)),
                ))
          ],
        )),
      ),
    );
  }
}
