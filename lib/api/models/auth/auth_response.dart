class AuthResponse {
  final String token;
  final String tokenType;
  final int expiresIn;

  AuthResponse({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    token: json['token'] as String,
    tokenType: json['token_type'] as String,
    expiresIn: json['expires_in'] as int,
  );
}
