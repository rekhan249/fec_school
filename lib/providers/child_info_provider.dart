// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'package:fec_app2/models/students_model.dart';
import 'package:fec_app2/models/textformfield_model.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ChildInfoProvider with ChangeNotifier {
  void onSubmittedStudentsForm(
      BuildContext context,
      List<TextFormFieldModel> textFields,
      final parentNameController,
      final classController) async {
    // ignore: unused_local_variable
    bool isNotValidate = false;
    print(textFields[0].text);
    AddStudent addStudent = AddStudent(
        id: 3,
        name: "unkown",
        childrenName: textFields.map((e) => e.text).toString(),
        email: "kkk@email.com",
        emailVerifiedAt: "null",
        role: 0,
        status: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
    var response = await http.post(Uri.parse(postStudents),
        headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
        body: json.encode(addStudent.toMap()));

    Navigator.pushNamed(context, DashBoard.routeName);
    Fluttertoast.showToast(msg: ' Student Created Successfully');

    notifyListeners();
  }
}
