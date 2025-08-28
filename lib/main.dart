import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/services/caching.dart';
import 'package:taskati/core/utils/theme.dart';
import 'package:taskati/features/splash/splash_screen.dart';

void main() async {
  await UserCachingService.init();
  await TaskCachingService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: UserCachingService.userBox.listenable(),
      builder: (context, userBox, child) {
        var isDark =
            UserCachingService.getUserData(UserCachingService.isDark) ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

          home: const SplashScreen(),
        );
      },
    );
  }
}
