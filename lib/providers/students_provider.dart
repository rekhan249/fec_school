// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class StudentsProvider with ChangeNotifier {
  void onSubmittedStudentsForm(BuildContext context, final studentName,
      final parentName, final classGrade) async {
    bool isNotValidate = false;

    var response = await http.post(Uri.parse(postStudents),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(''));

    var jsonRespose = jsonDecode(response.body);

    if (jsonRespose['status']) {
      Fluttertoast.showToast(
          msg: '${jsonRespose['status']} Student Created Successfully');
    } else {
      isNotValidate = true;
      Fluttertoast.showToast(msg: 'Student is not add yet');
    }

    notifyListeners();
  }
}
