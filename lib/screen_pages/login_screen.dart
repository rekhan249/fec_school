import 'package:fec_app2/providers/login_provider.dart';
import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/providers/switching_provvider.dart';
import 'package:fec_app2/screen_pages/signup_screen.dart';
import 'package:fec_app2/widgets/email_field.dart';
import 'package:fec_app2/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // ignore: unused_element
  void _submitLoginForm(BuildContext context) async {
    bool isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isvalid) {
      return;
    }
    _formKey.currentState!.save();

    Provider.of<LoginProvider>(context, listen: false).inLoginForm(
        context, _emailController.text.trim(), _passwordController.text.trim());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SwitchingProvider>(context, listen: false);
    final passwordProvider =
        Provider.of<PasswordProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Image.asset('assets/images/mainpage.png',
                    alignment: const FractionalOffset(0, 2),
                    height: 380,
                    fit: BoxFit.cover),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      color: const Color.fromARGB(255, 25, 74, 159)
                          .withOpacity(0.5),
                      height: 400.h,
                      width: 400.w,
                    )),
                Positioned(
                    child: Center(
                        child: Image.asset('assets/images/mainslogo.png',
                            height: 300.h, width: 220.w))),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(top: 280.h),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(25.r))),
                      child: Card(
                        margin: const EdgeInsets.all(05),
                        elevation: 0,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                  color:
                                      const Color.fromARGB(255, 25, 74, 159)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Consumer<SwitchingProvider>(
                                  builder: (context, sp, child) => ToggleSwitch(
                                    activeBgColor: const [Colors.amber],
                                    cornerRadius: 20,
                                    radiusStyle: true,
                                    inactiveBgColor:
                                        const Color.fromARGB(255, 25, 74, 159),
                                    initialLabelIndex: sp.isValue,
                                    totalSwitches: 2,
                                    labels: const ['Login', 'SignUp'],
                                    customTextStyles: const [
                                      TextStyle(color: Colors.white)
                                    ],
                                    onToggle: (index) {
                                      sp.isSwitching(index);
                                      if (index == 1) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpScreen()));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: EmailField(
                                emailController: _emailController,
                                hintText: 'Enter email here',
                                labelText: 'Email Address',
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Consumer<PasswordProvider>(
                                  builder: ((context, pp, child) =>
                                      PasswordField(
                                        passwordController: _passwordController,
                                        passwordProvider: passwordProvider,
                                        hintText: 'Enter password',
                                        labelText: 'Password',
                                      ))),
                            ),
                            SizedBox(height: 10.h),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text('Forget Password',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp)))),
                            SizedBox(height: 10.h),
                            SizedBox(
                                height: 50.h,
                                width: double.infinity.w,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 60.w),
                                  child: TextButton(
                                      onPressed: () =>
                                          _submitLoginForm(context),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 25, 74, 159))),
                                      child: Text('Log In',
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white))),
                                )),
                            SizedBox(height: 20.h),
                            // Padding(
                            //   padding: const EdgeInsets.all(15),
                            //   child: Align(
                            //     alignment: Alignment.center,
                            //     child: RichText(
                            //       text: TextSpan(
                            //         children: [
                            //           TextSpan(
                            //             text: 'Don’t have an account? ',
                            //             style: TextStyle(
                            //               color: Colors.black,
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 16.sp,
                            //             ),
                            //           ),
                            //           TextSpan(
                            //               text: 'Register',
                            //               style: TextStyle(
                            //                   color: Colors.red,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 18.sp),
                            //               recognizer: TapGestureRecognizer()
                            //                 ..onTap = () => Navigator.push(
                            //                     context,
                            //                     MaterialPageRoute(
                            //                         builder: (context) =>
                            //                             const SignUpScreen())))
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
