class AuthResponse {
  final int? id;
  String? firstName;
  String? lastName;
  String? email;
  bool? isActive;
  bool? isPengguna;
  String? token;
  String? foto;

  AuthResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.isActive,
    this.isPengguna,
    this.token,
    this.foto,
  });
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final profile = json['profil'];

    return AuthResponse(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      isActive: json['is_active'],
      isPengguna: json['is_pengguna'],
      token: json['token'],
      foto: profile['foto'] ?? '',
    );
  }
}
