import 'dart:io';

import 'package:fec_app2/providers/child_info_provider.dart';
import 'package:fec_app2/providers/dynamic_formfield_prov.dart';
import 'package:fec_app2/providers/login_provider.dart';
import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/providers/reset_password_provider.dart';
import 'package:fec_app2/providers/save_password_provider.dart';
import 'package:fec_app2/providers/signup_provider.dart';
import 'package:fec_app2/providers/switching_provvider.dart';
import 'package:fec_app2/routes_manage/page_route.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:fec_app2/services.dart/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await NotificationServices().initializationNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  runApp(MyApp(token: token != null));
}

class MyApp extends StatelessWidget {
  final bool token;
  const MyApp({super.key, required this.token});

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
                  ChangeNotifierProvider(
                      create: (context) => PasswordProvider()),
                  ChangeNotifierProvider(create: (context) => SignUpProvider()),
                  ChangeNotifierProvider(
                      create: (context) => SwitchingProvider()),
                  ChangeNotifierProvider(
                      create: (context) => ChildInfoProvider()),
                  ChangeNotifierProvider(
                      create: (context) => SavePasswordProvider()),
                  ChangeNotifierProvider(
                      create: (context) => ResetPasswordProvider()),
                  ChangeNotifierProvider(
                    create: (context) => TextFormFieldsProvider(),
                  ),
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'FEC School',
                  theme: ThemeData(
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: Colors.transparent),
                    useMaterial3: true,
                  ),
                  onGenerateRoute: (settings) => generateRoutes(settings),
                  home: token ? const DashBoard() : const LoginScreen(),
                )));
  }
}
