class Events {
  final List<Event> data;

  Events({
    required this.data,
  });

  factory Events.fromMap(map) => Events(
        data: List<Event>.from(map["data"].map((x) => Event.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Event {
  final int? id;
  final String? title;
  final String? type;
  final String? description;
  final String? summary;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Event({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.summary,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromMap(map) => Event(
      id: map["id"] ?? 0,
      title: map["title"],
      type: map["type"],
      description: map["description"],
      summary: map["summary"],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now());

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "type": type,
        "description": description,
        "summary": summary,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
