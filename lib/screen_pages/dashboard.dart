import 'package:fec_app2/screen_pages/child_info.dart';
import 'package:fec_app2/screen_pages/events.dart';
import 'package:fec_app2/screen_pages/forms.dart';
import 'package:fec_app2/screen_pages/notices.dart';
import 'package:fec_app2/screen_pages/profile.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoard extends StatefulWidget {
  static const String routeName = '/dashboard';
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const DashBoard({super.key, required this.token});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CurvedBottomClipper2(),
                  child: Container(
                    color: Colors.amber,
                    height: 212.h,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: -20,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 80.w),
                        child: ClipPath(
                          clipper: CurvedBottomClipper(),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.amber,
                                height: 211.h,
                                width: 400.w,
                                child: Image.asset(
                                    'assets/images/dashboard.png',
                                    fit: BoxFit.cover,
                                    alignment: const FractionalOffset(0, -0.5)),
                              ),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 25, 74, 159)
                                            .withOpacity(0.6),
                                    height: 211.h,
                                    width: 400.w,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 80.h,
                          left: 130.w,
                          right: 130.w,
                          child: Text(
                            'username',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.sp),
                          )),
                      Positioned(
                          top: 100.h,
                          left: 65.w,
                          right: 65.w,
                          child: Text(
                            'Welcome to FEC',
                            style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                      Positioned(
                        left: 20.w,
                        top: 175.h,
                        child: Container(
                          height: 40.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(width: 05, color: Colors.amber),
                            color: const Color.fromARGB(255, 25, 74, 159),
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Image.asset('assets/images/phone.png',
                                  color: Colors.white)),
                        ),
                      ),
                      Positioned(
                        left: 95.w,
                        top: 190.h,
                        child: Container(
                          height: 40.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(width: 05, color: Colors.amber),
                            color: const Color.fromARGB(255, 25, 74, 159),
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/mail.png',
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Positioned(
                          left: 175.w,
                          top: 188.h,
                          child: Container(
                              height: 40.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                border:
                                    Border.all(width: 05, color: Colors.amber),
                                color: const Color.fromARGB(255, 25, 74, 159),
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                      'assets/images/location.png',
                                      color: Colors.white)))),
                      Positioned(
                        left: 250.w,
                        top: 165.h,
                        child: Container(
                          height: 40.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(width: 05, color: Colors.amber),
                            color: const Color.fromARGB(255, 25, 74, 159),
                          ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ChildInformation.routeName);
                              },
                              icon: Image.asset(
                                'assets/images/childreninfo.png',
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Positioned(
                        left: 310.w,
                        top: 125.h,
                        child: Container(
                          height: 40.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(width: 05, color: Colors.amber),
                            color: const Color.fromARGB(255, 25, 74, 159),
                          ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ProfileInfo.routeName);
                              },
                              icon: Image.asset(
                                'assets/images/profile.png',
                                color: Colors.white,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            Center(
                child: Text(
              'Dashboard',
              style: TextStyle(
                  fontSize: 30.sp,
                  color: const Color.fromARGB(255, 25, 74, 159),
                  fontWeight: FontWeight.w700),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: const Divider(color: Colors.black),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, NoticesScreen.routeName);
                },
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(05.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 55.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 25, 74, 159),
                            borderRadius: BorderRadius.circular(07.r)),
                        child: Image.asset('assets/images/notices.png'),
                      ),
                      SizedBox(width: 15.w),
                      const Text('Notices'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, EventScreen.routeName);
                },
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(05.r)),
                  child: Row(
                    children: [
                      Container(
                        height: 55.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 25, 74, 159),
                            borderRadius: BorderRadius.circular(07.r)),
                        child: Image.asset('assets/images/events.png'),
                      ),
                      SizedBox(width: 15.w),
                      const Text('Events')
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, FormScreen.routeName);
                },
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(05.r)),
                  child: Row(
                    children: [
                      Container(
                        height: 55.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 25, 74, 159),
                            borderRadius: BorderRadius.circular(07.r)),
                        child: Image.asset('assets/images/forms.png'),
                      ),
                      SizedBox(width: 15.w),
                      const Text('Forms'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
