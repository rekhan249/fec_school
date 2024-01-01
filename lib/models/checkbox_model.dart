class CheckboxModel {
  final String label;
  final String value;
  bool selected;

  CheckboxModel(
      {required this.label, required this.value, required this.selected});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'value': value,
      'selected': selected,
    };
  }

  factory CheckboxModel.fromMap(Map<String, dynamic> map) {
    return CheckboxModel(
      label: map['label'] as String,
      value: map['value'] as String,
      selected: map['selected'] as bool,
    );
  }
}
