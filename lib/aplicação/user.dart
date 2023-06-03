class User {
  String id;
  String name;
  String email;
  String avatarUrl;
  String cargo;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.avatarUrl,
      required this.cargo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        avatarUrl: json['avatarUrl'],
        cargo: json['cargo']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'cargo': cargo
    };
  }
}
