class Folders {
  final List<Folder> data;

  Folders({
    required this.data,
  });

  factory Folders.fromMap(map) => Folders(
        data: List<Folder>.from(map["data"].map((x) => Folder.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Folder {
  final int? id;
  final int? folderId;
  final String? userId;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Folder({
    required this.id,
    required this.folderId,
    required this.userId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Folder.fromMap(map) => Folder(
      id: map["id"],
      folderId: map["folder_id"],
      userId: map["user_id"],
      name: map["name"],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now());

  Map<String, dynamic> toMap() => {
        "id": id,
        "folder_id": folderId,
        "user_id": userId,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
