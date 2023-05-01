import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:html' as html;

class SecureStorage {
  final _storage = html.window.localStorage;

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
