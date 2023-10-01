// ignore_for_file: unused_element
import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/models/folders_model.dart';
import 'package:http/http.dart' as http;
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FolderProvider {
  Future<List<Folder>> getUsers() async {
    List<Folder> foldersList = [];
    try {
      var url = Uri.parse(folder);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer zZT5D4MvFApZYy8fJZFbBEutfecgqB24CfDq5pbu',
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        var jsonRespose = json.decode(response.body);
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
