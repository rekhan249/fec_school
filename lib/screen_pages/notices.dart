// ignore_for_file: unused_element
import 'dart:convert';
import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/notice_title.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NoticesScreen extends StatefulWidget {
  static const String routeName = '/notices';
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  bool isNotValidate = false;
  Notice? notices;

  @override
  void initState() {
    dataNotices();

    super.initState();
  }

  void dataNotices() async {
    var response = await http.get(
      Uri.parse(notice),
      headers: {
        'Authorization': 'Bearer zZT5D4MvFApZYy8fJZFbBEutfecgqB24CfDq5pbu',
        "Content-Type": "application/json"
      },
    );
    var jsonRespose = jsonDecode(response.body);
    print(jsonRespose);
    notices = Notice(
        nid: int.tryParse(jsonRespose['nid']),
        title: jsonRespose['title'],
        type: jsonRespose['type'],
        description: jsonRespose['description'],
        summary: jsonRespose['summary'],
        createdAt: jsonRespose['createdAt'],
        updatedAt: jsonRespose['updatedAt']);
    Future<String> getToken() async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      return preferences.getString('token') ?? '';
    }

    if (jsonRespose['status']) {
      var myToken = jsonRespose['token'];

      Future<bool> setUserName() async {
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        return preferences.setString('token', myToken);
      }

      Fluttertoast.showToast(
          msg: '${jsonRespose['status']} Working Successfully');
    } else {
      Fluttertoast.showToast(msg: ' Error is something wrong');
      isNotValidate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: CurvedBottomClipper4(),
                    child: Container(
                      color: Colors.amber,
                      height: 140.h,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: CurvedBottomClipper3(),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.amber,
                                height: 133.h,
                                width: 400.w,
                                child: Image.asset(
                                  'assets/images/dashboard.png',
                                  fit: BoxFit.cover,
                                  alignment: const FractionalOffset(1, 1),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 25, 74, 159)
                                            .withOpacity(0.5),
                                    height: 133.h,
                                    width: 400.w,
                                  )),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 40.h,
                            left: 130.w,
                            right: 130.w,
                            child: Text(
                              'Notices',
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        Positioned(
                            top: 0.h,
                            left: 0.w,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context, DashBoard.routeName);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, NoticeTitle.routeName);
                  },
                  child: Container(
                    height: 140.h,
                    width: double.infinity.w,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notices Title',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          SizedBox(height: 05.h),
                          Text(
                              'Video provides a powerful way to help you prove your point. When you click Online Video, you can paste in the embed code for the video you want to add.',
                              style: TextStyle(fontSize: 12.sp)),
                          SizedBox(height: 15.h),
                          Text(
                            'Date: DD-MMM-YY',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const Divider(color: Colors.black26),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, NoticeTitle.routeName);
                  },
                  child: Container(
                    height: 140.h,
                    width: double.infinity.w,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notices Title',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          SizedBox(height: 05.h),
                          Text(
                              'Video provides a powerful way to help you prove your point. When you click Online Video, you can paste in the embed code for the video you want to add.',
                              style: TextStyle(fontSize: 12.sp)),
                          SizedBox(height: 15.h),
                          Text(
                            'Date: DD-MMM-YY',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const Divider(color: Colors.black26),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, NoticeTitle.routeName);
                  },
                  child: Container(
                    height: 140.h,
                    width: double.infinity.w,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notices Title',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          SizedBox(height: 05.h),
                          Text(
                              'Video provides a powerful way to help you prove your point. When you click Online Video, you can paste in the embed code for the video you want to add.',
                              style: TextStyle(fontSize: 12.sp)),
                          SizedBox(height: 15.h),
                          Text(
                            'Date: DD-MMM-YY',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
