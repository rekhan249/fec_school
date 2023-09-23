class Folders {
  final List<Folder> data;

  Folders({
    required this.data,
  });
  factory Folders.fromMap(map) => Folders(data: List<Folder>.from(map['data']));
  Map<String, dynamic> toMap() {
    return {"data": data};
  }
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
      id: map['id'] ?? 0,
      folderId: map['folderId'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '');

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "folderId": folderId,
      "userId": userId,
      "name": name,
      "createdAt": createdAt,
      "updatedAt": updatedAt
    };
  }
}
