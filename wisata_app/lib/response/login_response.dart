import 'package:wisata_app/response/auth_response.dart';

class LoginResponse {
  final AuthResponse? authResponse;
  final String message;
  LoginResponse({required this.authResponse, required this.message});
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    AuthResponse? authResponse;
    return LoginResponse(
        authResponse: json['data'] != null
            ? AuthResponse.fromJson(json['data'])
            : authResponse,
        message: json['message']);
  }
}
