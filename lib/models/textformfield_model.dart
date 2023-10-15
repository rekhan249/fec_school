class TextFormFieldModel {
  String text;

  TextFormFieldModel({required this.text});

  factory TextFormFieldModel.fromMap(map) =>
      TextFormFieldModel(text: map['text']);
  Map<String, dynamic> toMap() {
    return {"text": text};
  }
}
