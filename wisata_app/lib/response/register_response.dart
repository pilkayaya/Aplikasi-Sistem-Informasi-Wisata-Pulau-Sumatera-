class RegisterResponse {
  final String username;
  final String email;
  final bool isActive;
  final bool isPengguna;
  final String firstName;
  final String lastName;

  RegisterResponse({
    required this.username,
    required this.email,
    required this.isActive,
    required this.isPengguna,
    required this.firstName,
    required this.lastName,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      username: json['username'],
      email: json['email'],
      isActive: json['is_active'],
      isPengguna: json['is_pengguna'],
      firstName: json['first_name'],
      lastName: json['last_name'],

    );
  }
}
