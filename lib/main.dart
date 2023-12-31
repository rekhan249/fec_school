import 'dart:io';

import 'package:fec_app2/firebase_options.dart';
import 'package:fec_app2/providers/checkbox_provider.dart';
import 'package:fec_app2/providers/child_info_provider.dart';
import 'package:fec_app2/providers/date_time_provider.dart';
import 'package:fec_app2/providers/dropdown_provider.dart';
import 'package:fec_app2/providers/dynamic_formfield_prov.dart';
import 'package:fec_app2/providers/file_picker_provider.dart';
import 'package:fec_app2/providers/formdata_submission.dart';
import 'package:fec_app2/providers/login_provider.dart';
import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/providers/radiogroup_provider.dart';
import 'package:fec_app2/providers/reset_password_provider.dart';
import 'package:fec_app2/providers/save_password_provider.dart';
import 'package:fec_app2/providers/signup_provider.dart';
import 'package:fec_app2/providers/switching_provvider.dart';
import 'package:fec_app2/routes_manage/page_route.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundNotifications);
  runApp(MyApp(token: token != null));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundNotifications(
    RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print(message.notification!.title.toString());
  }
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
                  ChangeNotifierProvider(
                    create: (context) => FormDataSubmissionProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => CheckBoxProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => DropDownProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => RadioGroupProvider(),
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
