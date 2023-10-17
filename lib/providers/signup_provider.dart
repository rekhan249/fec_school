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
    try {
      var response = await http.post(Uri.parse(registration),
          headers: {
            "Accept": 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
            'Content-Type': 'application/json'
          },
          body: json.encode(userModelSignup.toMap()));

      var jsonRespose = jsonDecode(response.body.toString());

      if (jsonRespose['status']) {
        Fluttertoast.showToast(msg: 'Account Created Successfully');
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, LoginScreen.routeName);
      }
    } catch (e) {
      isNotValidate = true;
      Fluttertoast.showToast(msg: '$e Account is not created yet');
    }

    notifyListeners();
  }
}
