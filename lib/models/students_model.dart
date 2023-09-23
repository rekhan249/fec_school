class Students {
  final Student data;
  Students({
    required this.data,
  });
  factory Students.fromMap(map) => Students(data: map['data'] ?? '');
  Map<String, dynamic> toMap() {
    return {"data": data};
  }
}

class Student {
  final int? sid;
  final String? username;
  final List<String>? childrenName;
  final String? email;
  final String? emailVerifiedAt;
  final int? role;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Student({
    required this.sid,
    required this.username,
    required this.childrenName,
    required this.email,
    required this.emailVerifiedAt,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Student.fromMap(map) => Student(
      sid: map['sid'] ?? 0,
      username: map['username'] ?? '',
      childrenName: List<String>.from(map['childrenName']),
      email: map['email'] ?? '',
      emailVerifiedAt: map['emailVerifiedAt'] ?? '',
      role: map['role'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '');

  Map<String, dynamic> toMap() {
    return {
      "sid": sid,
      "username": username,
      "childrenName": childrenName,
      "email": email,
      "emailVerifiedAt": emailVerifiedAt,
      "role": role,
      "status": status,
      "createdAt": createdAt,
      "updatedAt": updatedAt
    };
  }
}
