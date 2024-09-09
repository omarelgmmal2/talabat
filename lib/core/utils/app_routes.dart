import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

/*class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (context) => const MainView(),
        );
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(
          builder: (context) => const StoreDetailsView(),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "No Route Found",
          ),
        ),
        body: const Center(
          child: Text(
            "No Route Found",
          ),
        ),
      ),
    );
  }
}*/
