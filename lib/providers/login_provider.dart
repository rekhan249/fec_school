// ignore_for_file: unused_element
import 'dart:convert';
import 'package:fec_app2/models/user_model_signin.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  // final _auth = FirebaseAuth.instance;
  // final firebaseFirestore = FirebaseFirestore.instance;

  void inLoginForm(BuildContext context, final email, final password) async {
    // ignore: unused_local_variable
    bool isNotValidate = false;

    UserModelSignIn userModelSignIn =
        UserModelSignIn(email: email, password: password);
    try {
      var response = await http.post(Uri.parse(login),
          headers: {
            "Accept": 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(userModelSignIn.toMap()));
      var jsonRespose = jsonDecode(response.body);

      if (jsonRespose['status']) {
        var myToken = jsonRespose['token'];

        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('token', myToken);

        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashBoard()));
        Fluttertoast.showToast(
            msg: '${jsonRespose['status']} Login Successfully');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e Error is something wrong');
      isNotValidate = true;
    }

    notifyListeners();
  }
}
