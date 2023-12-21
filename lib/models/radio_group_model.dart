class RadioGroupModel {
  final String label;
  final String value;
  final bool selected;

  RadioGroupModel(
      {required this.label, required this.value, required this.selected});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'value': value,
      'selected': selected,
    };
  }

  factory RadioGroupModel.fromMap(Map<String, dynamic> map) {
    return RadioGroupModel(
      label: map['label'] as String,
      value: map['value'] as String,
      selected: map['selected'] as bool,
    );
  }
}
