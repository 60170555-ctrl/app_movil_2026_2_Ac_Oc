import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/login_response.dart';
import '../models/token_pair.dart';
import '../models/user_profile.dart';

class AuthException implements Exception {
  const AuthException(this.message);
  final String message;
  @override
  String toString() => message;
}

class AuthService {
  AuthService({http.Client? client, FlutterSecureStorage? storage})
      : _client = client ?? http.Client(),
        _storage = storage ?? const FlutterSecureStorage();

  static const _kAccessToken = 'access_token';
  static const _kRefreshToken = 'refresh_token';
  static const _jsonHeaders = {'Content-Type': 'application/json'};

  final http.Client _client;
  final FlutterSecureStorage _storage;

  Uri _uri(String path) => Uri.parse('${AppConfig.apiBaseUrl}$path');

  // TODO 1: Login
  Future<void> login(String username, String password) async {
    final res = await _client.post(
      _uri('/auth/login'),
      headers: _jsonHeaders,
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': AppConfig.accessTokenMinutes,
      }),
    );

    if (res.statusCode != 200) {
      final error = jsonDecode(res.body);
      throw AuthException(error['message'] ?? 'Error al iniciar sesión');
    }

    final loginData = LoginResponse.fromJson(jsonDecode(res.body));
    await _storage.write(key: _kAccessToken, value: loginData.accessToken);
    await _storage.write(key: _kRefreshToken, value: loginData.refreshToken);
  }

  // TODO 2: hasSession
  Future<bool> hasSession() async {
    final refresh = await _storage.read(key: _kRefreshToken);
    return refresh != null;
  }

  // TODO 3: getProfile
  Future<UserProfile> getProfile() async {
    var token = await _storage.read(key: _kAccessToken);
    if (token == null) throw const AuthException('No hay sesión activa');

    var res = await _client.get(
      _uri('/auth/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    // Si el token venció, intenta renovar UNA vez
    if (res.statusCode == 401 || res.statusCode == 403) {
      final refreshed = await refreshSession();
      if (!refreshed) {
        await logout();
        throw const AuthException('Sesión expirada. Inicie sesión de nuevo.');
      }
      
      // Reintentar con el nuevo token
      token = await _storage.read(key: _kAccessToken);
      res = await _client.get(
        _uri('/auth/me'),
        headers: {'Authorization': 'Bearer $token'},
      );
    }

    if (res.statusCode != 200) {
      throw const AuthException('Error al obtener el perfil');
    }

    return UserProfile.fromJson(jsonDecode(res.body));
  }

  // TODO 4: refreshSession
  Future<bool> refreshSession() async {
    final refreshToken = await _storage.read(key: _kRefreshToken);
    if (refreshToken == null) return false;

    final res = await _client.post(
      _uri('/auth/refresh'),
      headers: _jsonHeaders,
      body: jsonEncode({
        'refreshToken': refreshToken,
        'expiresInMins': AppConfig.accessTokenMinutes,
      }),
    );

    if (res.statusCode != 200) return false;

    final tokenPair = TokenPair.fromJson(jsonDecode(res.body));
    await _storage.write(key: _kAccessToken, value: tokenPair.accessToken);
    await _storage.write(key: _kRefreshToken, value: tokenPair.refreshToken);
    return true;
  }

  // TODO 5: logout
  Future<void> logout() async {
    await _storage.delete(key: _kAccessToken);
    await _storage.delete(key: _kRefreshToken);
  }
}
