import 'package:flutter/cupertino.dart';
import 'package:task/features/authentication/screens/auth_screen.dart';
import 'package:task/features/authentication/screens/refresh_token_screen.dart';
import 'package:task/features/main_view/screens/main_view_screen.dart';
import 'package:task/features/onBoarding/screens/on_boarding_screen.dart';
import 'package:task/features/splash_screen/screens/splash_screen.dart';

class Routes {
  static Future<dynamic> splashScreen({required BuildContext context}) async {
    return Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => SplashPage()),
      (Route<dynamic> route) => false,
    );
  }

  static Future<dynamic> onBoardingScreen({
    required BuildContext context,
  }) async {
    return Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => OnBoardingScreen()),
      (Route<dynamic> route) => false,
    );
  }

  static Future<dynamic> authScreen({required BuildContext context}) async {
    return Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => AuthScreen()),
      (Route<dynamic> route) => false,
    );
  }

  static Future<dynamic> mainViewScreen({
    required BuildContext context,
    required bool isFromRegistration,
    required bool isNew,
    required String userId,
  }) async {
    return Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder:
            (context) => MainViewScreen(
              isFromRegistration: isFromRegistration,
              isNew: isNew,
              userId: userId,
            ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  static Future<dynamic> refreshTokenScreen({
    required BuildContext context,
    required String refreshToken,
  }) async {
    return Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RefreshTokenScreen(refreshToken: refreshToken),
      ),
    );
  }
}
