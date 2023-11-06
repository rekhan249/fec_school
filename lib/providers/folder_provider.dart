// ignore_for_file: unused_element, unnecessary_string_interpolations
import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/models/folders_model.dart';
import 'package:http/http.dart' as http;
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FolderProvider {
  Future<List<Folder>> getUsers() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    List<Folder> foldersList = [];
    try {
      var url = Uri.parse(folder);
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
        Folders folders = Folders.fromMap(jsonRespose);
        foldersList.addAll(folders.data);
      }
    } catch (e) {
      log(e.toString());
    }
    return foldersList;
  }
}
