import 'package:fec_app2/providers/child_info_provider.dart';
import 'package:fec_app2/providers/dynamic_formfield_prov.dart';
import 'package:fec_app2/providers/login_provider.dart';
import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/providers/reset_password_provider.dart';
import 'package:fec_app2/providers/save_password_provider.dart';
import 'package:fec_app2/providers/signup_provider.dart';
import 'package:fec_app2/providers/switching_provvider.dart';
import 'package:fec_app2/routes_manage/page_route.dart';
import 'package:fec_app2/screen_pages/child_info.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:fec_app2/services.dart/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationServices().initializationNotifications();

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
            ChangeNotifierProvider(create: (context) => SavePasswordProvider()),
            ChangeNotifierProvider(
                create: (context) => ResetPasswordProvider()),
            ChangeNotifierProvider(
              create: (context) => TextFormFieldsProvider(),
            ),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Society Management System',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              onGenerateRoute: (settings) => generateRoutes(settings),
              home: const LoginScreen())),
    );
  }
}
