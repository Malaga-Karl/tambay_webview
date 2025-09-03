import 'package:flutter/material.dart';
import 'package:tambay_webview/screens/infoscreen.dart';
import 'package:tambay_webview/screens/internet_checker.dart';
import 'package:tambay_webview/screens/webview_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // ← Rectangular
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {'/': (context) => const ConnectionChecker()},
      // routes: {'/': (context) => const WebViewScreen()},
      // routes: {'/': (context) => const Infoscreen()},
    );
  }
}
