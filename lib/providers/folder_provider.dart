// ignore_for_file: unused_element
import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/models/folders_model.dart';
import 'package:http/http.dart' as http;
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
          "Accept": 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        },
      );

      print('111111111111111111111111111${response.body}');
      var jsonRespose = json.decode(response.body);
      print('form status code${response.statusCode}');
      if (response.statusCode == 200) {
        Folders folders = Folders.fromMap(jsonRespose);
        foldersList.addAll(folders.data);
        if (jsonRespose['status']) {
          Fluttertoast.showToast(
              msg: '${jsonRespose['status']} Working Successfully');
        } else {
          Fluttertoast.showToast(msg: ' Error is something wrong');
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return foldersList;
  }
}
