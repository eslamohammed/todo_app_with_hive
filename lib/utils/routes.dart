
import 'package:flutter/material.dart';
import 'package:todo_app/screens/onboarding/OnBoardingView.dart';
import 'package:todo_app/screens/splash/splash_view.dart';
// import 'package:pretium_finance/screens/login/login_view.dart';
// import 'package:pretium_finance/screens/onboarding/OnBoardingView.dart';
// import 'package:pretium_finance/screens/register/register_view.dart';
// import 'package:pretium_finance/screens/splash/splash_view.dart';
// import '../screens/home/home_screen.dart';
import 'color_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeScreen = "/main";
  static const String detailsRoute = "/details";
  static const String onBoardingRoute = "/onBoarding";
  static const String registerRoute = "/register";
  static const String loginRoute = "/login";


}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      // case Routes.loginRoute:
      //   return MaterialPageRoute(builder: (_) => const LoginPage());
      // case Routes.registerRoute:
      //   return MaterialPageRoute(builder: (_) => const SignUpPage());
      // case Routes.homeScreen:
      //   return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text("No Route Founded!"),
              elevation: 1,
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.close_rounded,
                    size: 25.0,
                    color: ColorManager.error,
                  ),
                  Text("No Route Founded!"),
                ],
              ),
            ),
          ),
    );
  }
}
