import 'package:fec_app2/providers/child_info_provider.dart';
import 'package:fec_app2/providers/login_provider.dart';
import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/providers/signup_provider.dart';
import 'package:fec_app2/providers/switching_provvider.dart';
import 'package:fec_app2/routes_manage/page_route.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LoginProvider()),
            ChangeNotifierProvider(create: (context) => PasswordProvider()),
            ChangeNotifierProvider(create: (context) => SignUpProvider()),
            ChangeNotifierProvider(create: (context) => SwitchingProvider()),
            ChangeNotifierProvider(create: (context) => ChildInfoProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Society Management System',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            onGenerateRoute: (settings) => generateRoutes(settings),
            home: const LoginScreen(),
          )),
    );
  }
}
