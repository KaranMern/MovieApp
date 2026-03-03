import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageBase {
  Future<String?> getValue(String key);
  Future<void> setValue(String key, String value);
}

class SecureStorage implements SecureStorageBase{
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future<void> setValue(String keyName, String value) async {
    await storage.write(key: keyName, value: value);
  }

  Future<String?> getValue(String keyName) async {
    return await storage.read(key: keyName);
  }
}
