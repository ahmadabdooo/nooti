import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String _passwordKey = 'nooti_password';
  static const String _isPasswordSetKey = 'is_password_set';
  
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  Future<void> init() async {
    // Initialize any required setup
  }
  
  Future<bool> isPasswordSet() async {
    final isSet = await _storage.read(key: _isPasswordSetKey);
    return isSet == 'true';
  }
  
  Future<void> setPassword(String password) async {
    await _storage.write(key: _passwordKey, value: password);
    await _storage.write(key: _isPasswordSetKey, value: 'true');
  }
  
  Future<bool> verifyPassword(String password) async {
    final storedPassword = await _storage.read(key: _passwordKey);
    return storedPassword == password;
  }
  
  Future<void> removePassword() async {
    await _storage.delete(key: _passwordKey);
    await _storage.delete(key: _isPasswordSetKey);
  }
  
  Future<bool> isAppLocked() async {
    final isSet = await isPasswordSet();
    return isSet;
  }
}