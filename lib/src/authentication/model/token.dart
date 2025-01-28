class TokenResult {
  final String? accessToken;
  final String? refreshToken;
  final int? expiresAtMs;

  TokenResult({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAtMs,
  });
}
