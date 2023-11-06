import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<List<Notice>> getUsers() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    List<Notice>? noticesList = [];
    try {
      var url = Uri.parse(notice);
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
}
