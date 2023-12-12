import 'dart:io';

import 'package:fec_app2/providers/child_info_provider.dart';
import 'package:fec_app2/providers/date_time_provider.dart';
import 'package:fec_app2/providers/dynamic_formfield_prov.dart';
import 'package:fec_app2/providers/file_picker_provider.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
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
  // await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  await NotificationServices().initializationNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD-Y1sgq2bu3eNMTXjifpXRoGHmRgXL2GM",
            authDomain: "fec-school-app.firebaseapp.com",
            projectId: "fec-school-app",
            storageBucket: "fec-school-app.appspot.com",
            messagingSenderId: "246569139275",
            appId: "1:246569139275:web:33c6276fbf620e562761ce",
            measurementId: "G-K75BNX7C9K"));
  } else {
    await Firebase.initializeApp();
  }

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
                  ChangeNotifierProvider(
                    create: (context) => FilePickerProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => DateTimeProvider(),
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
