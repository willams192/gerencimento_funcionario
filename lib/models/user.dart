class User {
  final String id;
  final String name;
  final String email;
  final String avatarurl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarurl,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      avatarurl: map['avatarurl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarurl': avatarurl,
    };
  }
}
