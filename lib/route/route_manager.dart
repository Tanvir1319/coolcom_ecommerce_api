import 'package:coolcom/models/product_model.dart';
import 'package:coolcom/pages/details_page/ui/details_page.dart';
import 'package:coolcom/pages/home_page.dart';
import 'package:coolcom/pages/login_page.dart';
import 'package:coolcom/pages/main_page/ui/main_page.dart';
import 'package:coolcom/route/middlewares/auth_middleware.dart';
import 'package:go_router/go_router.dart';

class RouteManager {
  static final  routeConfig = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: RouteNames.LOGIN,
        path: "/",
        
        builder: (context, state) => LoginPage(),
        ),
        GoRoute(
            name: RouteNames.MAIN_PAGE,
            path: RouteNames.MAIN_PAGE,
            builder: (context,state) => const MainPage(),
            routes: [
              GoRoute(
                name: RouteNames.DETAILS,
                path: RouteNames.DETAILS,
                builder: (context, state) => DetailsPage( product: state.extra as ProductModel ), 
              ),
            ]
          ),
        
      
    ],
  );
}

abstract class RouteNames {
  static String MAIN_PAGE = '/main';
  static String LOGIN = '/';
  static String DETAILS = 'details';
}
