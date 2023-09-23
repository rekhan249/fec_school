class UserModelSignIn {
  final String email;
  final String password;

  UserModelSignIn({required this.email, required this.password});

  factory UserModelSignIn.fromMap(map) =>
      UserModelSignIn(email: map["email"], password: map["password"]);

  Map<String, dynamic> toMap() {
    return {"email": email, "password": password};
  }
}
