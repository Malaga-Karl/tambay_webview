import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tambay_webview/screens/no_internet_screen.dart';
import 'package:tambay_webview/screens/webview_screen.dart';

class ConnectionChecker extends StatefulWidget {
  const ConnectionChecker({super.key});

  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  late final StreamSubscription<List<ConnectivityResult>> subscription;
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    subscription = Connectivity().onConnectivityChanged.listen((results) {
      setState(() {
        hasInternet = results.any(
          (result) => result != ConnectivityResult.none,
        );
      });
    });
  }

  Future<void> _checkConnection() async {
    var results = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = results.any((result) => result != ConnectivityResult.none);
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasInternet) {
      return const WebViewScreen();
    } else {
      return const NoInternetScreen();
    }
  }
}
