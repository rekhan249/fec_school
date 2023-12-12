import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerProvider with ChangeNotifier {
  String _fileLink = "";
  String get fileLink => _fileLink;

  Future<String> filePickerFromGallery(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      File filePath = File(result.files.single.path!);
      _fileLink = filePath.path;
      notifyListeners();
    }
    return _fileLink;
  }
}
