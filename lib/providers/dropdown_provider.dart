// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:developer';

import 'package:fec_app2/models/dropdown_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DropDownProvider with ChangeNotifier {
  DropDownModel? _dropDownModel;

  List<List<DropDownModel>> _dropDownsList = [];
  DropDownModel? get dropDownModel => _dropDownModel;
  List<List<DropDownModel>> get dropDownsList => _dropDownsList;

  Future<void> apiAccessDropDown(int? id) async {
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
            if (jsonRespose['data'][i]["form_data"][j]["type"] == "select") {
              List<dynamic> dataDynamic =
                  jsonRespose['data'][i]["form_data"][j]["values"];
              List<DropDownModel> dropDownListOne = dataDynamic.map((e) {
                return DropDownModel.fromMap(e);
              }).toList();
              _dropDownsList.add(dropDownListOne);
              notifyListeners();
              // print(
              //     'before update ${_dropDownsList.map((e) => e.map((e) => e.toMap()))}');
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void dropDownSelectOne(DropDownModel? value) {
    _dropDownsList.map((e) => e.map((e) {
          e = value!;
          notifyListeners();
        }));
    // print('after update ${_dropDownsList.map((e) => e.map((e) => e.toMap()))}');
  }
}
