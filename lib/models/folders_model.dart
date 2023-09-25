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
      createdAt: map['createdAt'] ?? DateTime.now(),
      updatedAt: map['updatedAt'] ?? DateTime.now());

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
