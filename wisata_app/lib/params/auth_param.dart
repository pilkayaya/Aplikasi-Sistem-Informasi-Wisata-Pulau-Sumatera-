class AuthParam{
  final String? username;
  final String? password;

  AuthParam({required this.username, required this.password});
  Map<String, dynamic> toJson() {
    return{
      'username' : username,
      'password' : password
    };
  }
}
