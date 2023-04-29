import 'package:coolcom/core/constants/shared_preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenDatasource {
  late SharedPreferences _preferences;

  TokenDatasource(this._preferences);
  //save token method
  Future<bool> save(String token) async {
    bool isTokenSaved =
        await _preferences.setString(SharedPreferencesKeys.TOKEN, token);
    if (isTokenSaved) {
      return true;
    }
    return false;
  }

  //get token
  String? get() {
    _preferences.getString(SharedPreferencesKeys.TOKEN);
  }

  //delete token
  Future<bool> delete() async {
    return _preferences.remove(SharedPreferencesKeys.TOKEN);
  }
}
