import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//deals with the token encryption in local storage
class UserSecureStorage{
  static const _storage = FlutterSecureStorage();
  static const _keyAccessToken = 'access_token';
  static const _keyRefreshToken = 'refresh_token';

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
   );

  static Future setAccessToken(String accessToken) async{  
    await _storage.write(key: _keyAccessToken, value: accessToken);
  }
  static Future<String?> getAccessToken() async{
    var readAccess = await _storage.read(key: _keyAccessToken);
    return readAccess;
  }
  static Future setRefreshToken(String refreshToken) async{
    await _storage.write(key: _keyRefreshToken, value: refreshToken);
  }
  static Future<String?> getRefreshToken() async{
    var readRefresh = await _storage.read(key: _keyRefreshToken);
    return readRefresh;
  }
}