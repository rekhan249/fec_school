import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:fec_app2/widgets/email_field.dart';
import 'package:fec_app2/widgets/name_field.dart';
import 'package:fec_app2/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
            SizedBox(height: 40.h),
          ],
        ),
      ),
    ));
  }
}
