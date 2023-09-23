class Student {
  final List<String> data;

  Student({
    required this.data,
  });
  factory Student.fromMap(map) => Student(data: List<String>.from(map['data']));
}
