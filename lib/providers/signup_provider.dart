import 'dart:convert';
import 'package:fec_app2/models/user_model_signup.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SignUpProvider with ChangeNotifier {
  void onSubmittedSignUpForm(
      BuildContext context, final username, final email, final password) async {
    // ignore: unused_local_variable
    bool isNotValidate = false;

    UserModelSignup? userModelSignup =
        UserModelSignup(name: username, email: email, password: password);

    var response = await http.post(Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userModelSignup.toMap()));

    var jsonRespose = jsonDecode(response.body);

    if (jsonRespose['status']) {
      Fluttertoast.showToast(
          msg: '${jsonRespose['status']} Account Created Successfully');
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, LoginScreen.routeName);
    } else {
      isNotValidate = true;
      Fluttertoast.showToast(msg: 'Account is not created yet');
    }

    notifyListeners();
  }
}
