import 'package:coolcom/core/constants/shared_preference_keys.dart';
import 'package:coolcom/route/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //context.goNamed(RouteNames.HOME_PAGE);
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            bool isTokenCleared =
                await sharedPreferences.remove(SharedPreferencesKeys.TOKEN);
            if (isTokenCleared) {
              print("Logged Out");
            } else {
              print('Sorry');
            }

            context.goNamed(RouteNames.LOGIN);
          },
          child: Text('bk')),
    );
  }
}
