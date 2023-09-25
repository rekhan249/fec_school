// ignore_for_file: unused_element
import 'dart:convert';
import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class NoticesProvider with ChangeNotifier {
  Notice? _notices;

  Notice? get notices => _notices;
  Future<void> fetchNotice() async {
    final response = await dataNotices();
    _notices = response.toMap() as Notice?;
    notifyListeners();
  }
}

Future<Notice> dataNotices() async {
  var response = await http.get(
    Uri.parse(notice),
    headers: {
      'Authorization': 'Bearer zZT5D4MvFApZYy8fJZFbBEutfecgqB24CfDq5pbu',
      "Content-Type": "application/json"
    },
  );
  var jsonRespose = jsonDecode(response.body);

  if (jsonRespose['status']) {
    Fluttertoast.showToast(
        msg: '${jsonRespose['status']} Working Successfully');
  } else {
    Fluttertoast.showToast(msg: ' Error is something wrong');
  }
  return Notice.fromMap(jsonRespose);
}
