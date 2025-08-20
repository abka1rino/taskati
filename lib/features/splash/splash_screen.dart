import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/splash/new%20user%20screen/new_user_screeen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      pushWithReplacement(context, NewUserScreen());
    });
    super.initState();

    // Perform any initialization tasks here
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(AppAssets.logo),
            SizedBox(height: 15),
            Text('Taskati', style: TextStyles.getTitle()),
            SizedBox(height: 15),
            Text('It\'s Time to Get Organized', style: TextStyles.getBody()),
          ],
        ),
      ),
    );
  }
}
