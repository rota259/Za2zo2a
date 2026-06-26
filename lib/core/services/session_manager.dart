import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists the JWT and the cached current user in the platform secure store
/// (Keychain on iOS, EncryptedSharedPreferences on Android).
///
/// Registered as a singleton in the DI container so the dio interceptor, the
/// auth flow and the boot sequence all share one source of truth.
class SessionManager {
  static const _kToken = 'auth_token';
  static const _kUser = 'auth_user';
  static const _kWallet = 'driver_wallet';
  static const _kBank = 'driver_bank';
  static const _kProfilePhoto = 'driver_profile_photo';

  final FlutterSecureStorage _storage;

  SessionManager([FlutterSecureStorage? storage])
    : _storage = storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          );

  /// In-memory cache so the dio interceptor can attach the token without an
  /// async disk read on every single request. Hydrated by [bootstrap].
  String? _cachedToken;

  String? get cachedToken => _cachedToken;
  bool get isLoggedIn => _cachedToken != null && _cachedToken!.isNotEmpty;

  /// Call once at app start to warm the in-memory token cache.
  Future<void> bootstrap() async {
    _cachedToken = await _storage.read(key: _kToken);
  }

  Future<void> saveToken(String token) async {
    _cachedToken = token;
    await _storage.write(key: _kToken, value: token);
  }

  Future<String?> readToken() async {
    return _cachedToken ??= await _storage.read(key: _kToken);
  }

  Future<void> saveUser(Map<String, dynamic> userJson) async {
    await _storage.write(key: _kUser, value: jsonEncode(userJson));
  }

  Future<Map<String, dynamic>?> readUser() async {
    final raw = await _storage.read(key: _kUser);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  // ── Wallet / Bank (persisted locally until backend supports it) ──────
  Future<void> saveWallet(String walletNumber) async {
    await _storage.write(key: _kWallet, value: walletNumber);
  }

  Future<String?> readWallet() async {
    return _storage.read(key: _kWallet);
  }

  Future<void> saveBank(Map<String, String> bank) async {
    await _storage.write(key: _kBank, value: jsonEncode(bank));
  }

  Future<Map<String, String>?> readBank() async {
    final raw = await _storage.read(key: _kBank);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw);
      return decoded is Map ? Map<String, String>.from(decoded) : null;
    } catch (_) {
      return null;
    }
  }

  // ── Profile photo (local path) ────────────────────────────────────────
  Future<void> saveProfilePhoto(String path) async {
    await _storage.write(key: _kProfilePhoto, value: path);
  }

  Future<String?> readProfilePhoto() async {
    return _storage.read(key: _kProfilePhoto);
  }

  /// Wipe everything — called on logout, account deletion and 401.
  Future<void> clear() async {
    _cachedToken = null;
    await _storage.delete(key: _kToken);
    await _storage.delete(key: _kUser);
  }
}
