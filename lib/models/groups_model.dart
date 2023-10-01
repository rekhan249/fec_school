class Groups {
  final List<Group> data;

  Groups({
    required this.data,
  });

  factory Groups.fromMap(Map<String, dynamic> json) => Groups(
        data: List<Group>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "data": List<Group>.from(data.map((x) => x)),
      };
}

class Group {}
