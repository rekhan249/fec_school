class Notices {
  List<Notice> data;

  Notices({required this.data});

  factory Notices.fromMap(map) => Notices(data: List<Notice>.from(map['data']));

  Map<String, dynamic> toMap() {
    return {"data": data};
  }
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
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      summary: map['summary'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '');

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
