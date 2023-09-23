class Groups {
  final List<Group> data;

  Groups({
    required this.data,
  });

  factory Groups.fromMap(map) => Groups(data: List<Group>.from(map['data']));
  Map<String, dynamic> toMap() {
    return {"data": data};
  }
}

class Group {}
