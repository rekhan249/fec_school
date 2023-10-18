// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'dart:convert';
import 'package:fec_app2/models/textformfield_model.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ChildInfoProvider with ChangeNotifier {
  void onSubmittedStudentsForm(BuildContext context,
      List<TextFormFieldModel> textFields, String token) async {
    Map<String, dynamic> student = {
      "children_name": [textFields.elementAt(0).text.toString()]
    };

    Map<String, dynamic> student1 = {
      "children_name": [
        for (int i = 0; i < textFields.length; i++)
          textFields[i].text.toString()
      ]
    };
    bool isNotValidate = false;

    print('ppppppppppp ${student1}');
    try {
      var response = await http.post(Uri.parse(postStudents),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(student1));
      print('respose ${response.body.toString()}');
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: ' Student Created Successfully');
        Navigator.pushNamed(context, DashBoard.routeName);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e Something Went Wrong');
      print('eeeeeeeeeeeeeee $e');
    }

    notifyListeners();
  }
}
