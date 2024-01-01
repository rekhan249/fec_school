// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/models/checkbox_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckBoxProvider with ChangeNotifier {
  CheckboxModel? _checkboxModel;
  List<List<CheckboxModel>> _checkboxsList = [];
  CheckboxModel? get checkboxModel => _checkboxModel;
  List<List<CheckboxModel>> get checkboxsList => _checkboxsList;

  Future<void> apiAccessCheckBoxes(int? id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String? token = preferences.getString('token');

    // ignore: unnecessary_brace_in_string_interps
    String noticeAPI = '$notice$id';

    try {
      var url = Uri.parse(noticeAPI);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
          "Accept": 'application/json',
        },
      );

      var jsonRespose = json.decode(response.body);
      if (response.statusCode == 200) {
        for (int i = 0; i < (jsonRespose['data'] as List).length; i++) {
          for (int j = 0;
              j < (jsonRespose['data'][i]["form_data"] as List).length;
              j++) {
            if (jsonRespose['data'][i]["form_data"][j]["type"] ==
                "checkbox-group") {
              List<dynamic> dataDynamic =
                  jsonRespose['data'][i]["form_data"][j]["values"];
              List<CheckboxModel> checkboxListOne = dataDynamic.map((e) {
                return CheckboxModel.fromMap(e);
              }).toList();
              _checkboxsList.add(checkboxListOne);
              notifyListeners();
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void selectUnselectCheckboxe(
      bool? value, CheckboxModel checkboxModel, int index) {
    // print('map ${checkboxModel.toMap()} index $index');

    for (int k = 0; k < _checkboxsList.length; k++) {
      if (_checkboxsList[k].contains(checkboxModel)) {
        if (index >= 0 && index < _checkboxsList[k].length) {
          _checkboxsList[k][index].selected =
              !_checkboxsList[k][index].selected;
        }
      }
    }
    notifyListeners();
  }
}
