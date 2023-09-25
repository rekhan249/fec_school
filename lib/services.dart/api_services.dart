import 'dart:developer';
import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Notice?> getUsers() async {
    try {
      var url = Uri.parse(notice);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer zZT5D4MvFApZYy8fJZFbBEutfecgqB24CfDq5pbu',
          "Content-Type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        Notice notices = Notice.fromMap(response.body);
        return notices;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
