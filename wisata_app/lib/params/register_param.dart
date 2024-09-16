class RegisterParam {
  final String username;
  final String email;
  final String password;
  final String password2;
  final String firstName;
  final String lastName;
  final bool isActive;
  final bool isPengguna;

  RegisterParam({
    required this.username,
    required this.email,
    required this.password,
    required this.password2,
    required this.firstName,
    required this.lastName,
    required this.isActive,
    required this.isPengguna,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'password2': password2,
      'first_name': firstName,
      'last_name': lastName,
      'is_active': isActive,
      'is_pengguna': isPengguna,
    };
  }
}
