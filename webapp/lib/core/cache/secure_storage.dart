import 'dart:html' as html;

class SecureStorage {
  final _storage = html.window.localStorage;

  SecureStorage._internal();

  static final SecureStorage _secureStorage = SecureStorage._internal();

  factory SecureStorage() {
    return _secureStorage;
  }

  Future writeSecureData(String key, String value) async {
    _storage[key] = value;

    return _storage[key];
  }

  Future<String?> readSecureData(String key) async {
    return _storage[key];
  }

  Future deleteSecureData(String key) async {
    return _storage.remove(key);
  }
}
