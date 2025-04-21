import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:task/global/methods_helpers_functions/constants.dart';
import 'package:task/global/methods_helpers_functions/local_storage_helper.dart';
import 'package:task/global/navigation_routes/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void initializePage() async {
    try {
      bool? isAuthenticated = await LocalStorageHelper.getBool(
        key: 'is_authenticated',
      );
      if (!mounted) return;
      if (isAuthenticated == true) {
        Routes.mainViewScreen(context: context, isFromRegistration: false, isNew: false,userId:"");
      } else {
        Routes.onBoardingScreen(context: context);
      }
    } catch (e) {
      debugPrint("Error retrieving authentication status: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 30.0),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Hal HR Task',
                speed: Duration(milliseconds: 150),
                textStyle: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
            onFinished: () {
              initializePage();
            },
            isRepeatingAnimation: false,
            repeatForever: false,
            displayFullTextOnTap: false,
          ),
        ),
      ),
    );
  }
}
