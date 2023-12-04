import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';

class ApiService {
  Future<List<Notice>> getUsers() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String? token1 = preferences.getString('token');

    String? token = "71|N1yLNmfB4xaVWSWB0oTFSw6MGHnPGLvDzgvVUB872f801694";

    List<Notice>? noticesList = [];
    try {
      var url = Uri.parse(noticeList);
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
        Notices notices = Notices.fromJson(jsonRespose);

        noticesList.addAll(notices.data);
      }
    } catch (e) {
      log(e.toString());
    }
    return noticesList;
  }

  Future<Notice> getUserSingle(int? id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String? token1 = preferences.getString('token');

    String? token = "71|N1yLNmfB4xaVWSWB0oTFSw6MGHnPGLvDzgvVUB872f801694";
    String noticeAPI = '$notice${id}';
    print(noticeAPI);

    Notice? noticeValue;
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
        Notice? noticeVal = Notice.fromJson(jsonRespose["data"][id]);
        noticeValue = noticeVal;
        print('===========> $noticeValue <===========');
      }
    } catch (e) {
      log(e.toString());
    }
    return noticeValue!;
  }
}
