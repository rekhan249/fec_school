class Event {
  final int? eid;
  final String? title;
  final String? type;
  final String? description;
  final String? summary;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Event({
    required this.eid,
    required this.title,
    required this.type,
    required this.description,
    required this.summary,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Event.fromMap(map) => Event(
      eid: map['eid'] ?? 0,
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      summary: map['summary'] ?? '',
      createdAt: map['createdAt'] ?? DateTime.now(),
      updatedAt: map['updatedAt'] ?? DateTime.now());

  Map<String, dynamic> toMap() {
    return {
      "eid": eid,
      "title": title,
      "type": type,
      "description": description,
      "summary": summary,
      "createdAt": createdAt,
      "updatedAt": updatedAt
    };
  }
}
