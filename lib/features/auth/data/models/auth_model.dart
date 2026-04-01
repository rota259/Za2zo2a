class AuthModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String token;

  AuthModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
    };
  }
}
