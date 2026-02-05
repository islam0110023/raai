import 'dart:developer';

class TokenManager {
  String? _accessToken;

  String? get accessToken => _accessToken;

  bool get isLoggedIn => _accessToken != null;

  void saveAccessToken(String token) {
    _accessToken = token;
  }

  void clear() {
    _accessToken = null;
    log('logged out');
  }
}
