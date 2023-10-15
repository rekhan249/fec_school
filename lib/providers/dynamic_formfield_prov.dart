// ignore_for_file: prefer_final_fields

import 'package:fec_app2/models/textformfield_model.dart';
import 'package:flutter/material.dart';

class TextFormFieldsProvider extends ChangeNotifier {
  List<TextFormFieldModel> _textFields = [TextFormFieldModel(text: "")];
  List<TextFormFieldModel> get textFields => _textFields;

  void addTextField(String text) {
    _textFields.add(TextFormFieldModel(text: text));
    notifyListeners();
  }

  void removeTextField(int index) {
    if (_textFields.length > 1) {
      _textFields.removeAt(index);
      notifyListeners();
    }
  }
}
