import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:fec_app2/widgets/email_field.dart';
import 'package:fec_app2/widgets/name_field.dart';
import 'package:fec_app2/widgets/password_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfo extends StatefulWidget {
  static const String routeName = '/profile-info';
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
    final passwordProvider =
        Provider.of<PasswordProvider>(context, listen: false);
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
                  clipper: CurvedBottomClipper5(),
                  child: Container(
                    color: Colors.amber,
                    height: 210.h,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: CurvedBottomClipper(),
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.amber,
                              height: 203.h,
                              width: 400.w,
                              child: Image.asset(
                                'assets/images/dashboard.png',
                                fit: BoxFit.cover,
                                alignment: const FractionalOffset(1.5, 0.5),
                              ),
                            ),
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  color: const Color.fromARGB(255, 25, 74, 159)
                                      .withOpacity(0.5),
                                  height: 211.h,
                                  width: 400.w,
                                )),
                            Positioned(
                                left: 80,
                                child: Center(
                                    child: Image.asset(
                                        'assets/images/mainslogo.png',
                                        height: 180.h,
                                        width: 200.w))),
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
                ),
              ],
            ),
            SizedBox(height: 40.h),
            Center(
                child: Text(
              'Profile',
              style: TextStyle(
                  fontSize: 30.sp,
                  color: const Color.fromARGB(255, 25, 74, 159),
                  fontWeight: FontWeight.w700),
            )),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Text(
                'Name:',
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
              ),
            ),
            SizedBox(height: 05.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: NameField(
                nameController: _nameController,
                hintText: 'Enter your full name',
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Text(
                'Email:',
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
              ),
            ),
            SizedBox(height: 05.h),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: EmailField(
                    emailController: _emailController,
                    hintText: 'Enter email address here',
                    labelText: 'Email Address')),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Text(
                'Password:',
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
              ),
            ),
            SizedBox(height: 05.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Consumer<PasswordProvider>(
                  builder: ((context, pp, child) => PasswordField(
                        passwordController: _passwordController,
                        passwordProvider: passwordProvider,
                        hintText: 'Enter password',
                        labelText: 'Password',
                        icon: Icon(passwordProvider.isObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                        colors: passwordProvider.isObscure
                            ? Colors.black
                            : Colors.red,
                      ))),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Text(
                'Confirm password:',
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
              ),
            ),
            SizedBox(height: 05.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Consumer<PasswordProvider>(
                  builder: ((context, pp, child) => PasswordField(
                        passwordController: _confirmPasswordController,
                        passwordProvider: passwordProvider,
                        hintText: 'Enter confirm password',
                        labelText: 'Confirm password',
                        icon: Icon(
                          passwordProvider.isObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        colors: passwordProvider.isObscure
                            ? Colors.black
                            : Colors.red,
                      ))),
            ),
            SizedBox(height: 40.h),
            SizedBox(
                height: 50.h,
                width: double.infinity.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.h),
                  child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          shape:
                              const MaterialStatePropertyAll(LinearBorder.none),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 25, 74, 159))),
                      child: Text('Update',
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                )),
            SizedBox(height: 20.h),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await logoutUser();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
                style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(LinearBorder.none),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.grey.shade200),
                    elevation: const MaterialStatePropertyAll(0)),
                child: Text('Logout',
                    style: TextStyle(color: Colors.black.withOpacity(0.6))),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    ));
  }

  Future<void> logoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Fluttertoast.showToast(msg: "User Logout Successfully");
  }
}
