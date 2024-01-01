// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:developer';

import 'package:fec_app2/models/radio_group_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RadioGroupProvider with ChangeNotifier {
  RadioGroupModel? _radioGroupModel;
  List<List<RadioGroupModel>> _radioGroupsList = [];
  RadioGroupModel? get radioGroupModel => _radioGroupModel;
  List<List<RadioGroupModel>> get radioGroupsList => _radioGroupsList;

  Future<void> apiAccessRadioGroupes(int? id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String? token = preferences.getString('token');
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
                "radio-group") {
              List<dynamic> dataDynamic =
                  jsonRespose['data'][i]["form_data"][j]["values"];
              List<RadioGroupModel> radioGroupListOne = dataDynamic.map((e) {
                return RadioGroupModel.fromMap(e);
              }).toList();
              _radioGroupsList.add(radioGroupListOne);

              notifyListeners();
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
