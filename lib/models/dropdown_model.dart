class DropDownModel {
  final String label;
  final String value;
  final bool selected;

  DropDownModel(
      {required this.label, required this.value, required this.selected});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'value': value,
      'selected': selected,
    };
  }

  factory DropDownModel.fromMap(Map<String, dynamic> map) {
    return DropDownModel(
      label: map['label'] as String,
      value: map['value'] as String,
      selected: map['selected'] as bool,
    );
  }
}
