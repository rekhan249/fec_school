import 'package:fec_app2/models/folders_model.dart';
import 'package:fec_app2/screen_pages/forms.dart';
import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class FormTitle extends StatefulWidget {
  final Folder folderValue;
  const FormTitle({super.key, required this.folderValue});

  @override
  State<FormTitle> createState() => _FormTitleState();
}

class _FormTitleState extends State<FormTitle> {
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

  String removeHtmlTags(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 25, 74, 159),
          leading: IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, FormScreen.routeName);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          title: ListTile(
            title: Text(
              widget.folderValue.name.toString(),
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            subtitle: Text(
              DateFormat('dd-MM-yyyy - HH:mm')
                  .format(widget.folderValue.createdAt!)
                  .toString(),
              style: TextStyle(color: Colors.white, fontSize: 10.sp),
            ),
          ),
          actions: [
            Container(
                height: 50.h,
                width: 80.w,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Image.asset('assets/images/feclogos.png'))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            ClipPath(
              clipper: StraightBorderClipper(
                  borderWidth: 0), // Adjust the border width as needed
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
                  child: Text(widget.folderValue.updatedAt.toString(),
                      style: TextStyle(fontSize: 14.sp)),
                ))
          ],
        )),
      ),
    );
  }
}
