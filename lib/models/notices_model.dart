class Notices {
  List<Notice> data;

  Notices({
    required this.data,
  });

  factory Notices.fromJson(Map<String, dynamic> json) => Notices(
        data: List<Notice>.from(json["data"].map((x) => Notice.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Notice {
  final int? nid;
  final String? title;
  final String? type;
  final String? description;
  final String? summary;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Notice(
      {required this.nid,
      required this.title,
      required this.type,
      required this.description,
      required this.summary,
      required this.createdAt,
      required this.updatedAt});

  factory Notice.fromMap(map) => Notice(
      nid: map['nid'] ?? 0,
      title: map['title'],
      type: map['type'],
      description: map['description'],
      summary: map['summary'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now());

  Map<String, dynamic> toMap() {
    return {
      "nid": nid,
      "title": title,
      "type": type,
      "description": description,
      "summary": summary,
      "createdAt": createdAt,
      "updatedAt": updatedAt
    };
  }
}
