import 'package:flutter/material.dart';
import 'package:to_do_app/screens/splash_screen.dart';

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          themeMode: themeNotifier,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
          ),

          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
