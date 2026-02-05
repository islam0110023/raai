import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:raai/core/utils/constants.dart';

abstract class SecureStorage {
  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  static IOSOptions _getIosOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static final _storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
    iOptions: _getIosOptions(),
  );

  static Future<void> saveData({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);
      log('SecureStorage saved: $value');
    } catch (e) {
      log('SecureStorage error: $e');
      await _storage.deleteAll();
      await _storage.write(key: key, value: value);
    }
  }

  static Future<void> saveUserToken({required String? token}) async {
    await saveData(
      key: AppConstant.cacheKeyUserTokenKeyName,
      value: token ?? '',
    );
  }

  static Future<void> clear() async {
    await _storage.delete(key: AppConstant.cacheKeyUserTokenKeyName);
    log('SecureStorage cleared');
  }

  static Future<String?> getUserToken() async {
    return await getData(key: AppConstant.cacheKeyUserTokenKeyName);
  }

  static Future<String?> getData({required String key}) async {
    return await _storage.read(key: key);
  }

  static Future<void> deleteData({required String key}) async {
    await _storage.delete(key: key);
  }
}
