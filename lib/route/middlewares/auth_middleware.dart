import 'package:coolcom/core/constants/shared_preference_keys.dart';
import 'package:coolcom/datasources/token_datasouce.dart';
import 'package:coolcom/route/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMiddleware {
  static Future<String?> guardWithLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    TokenDatasource tokenDatasource = TokenDatasource(sharedPreferences);
    String? token=tokenDatasource.get();
    if (token != null) {
      return RouteNames.MAIN_PAGE;
    }
    return null;
  }
}
