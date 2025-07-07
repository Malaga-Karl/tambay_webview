import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tambay_webview/screens/no_internet_screen.dart';

class ConnectionChecker extends StatefulWidget {
  const ConnectionChecker({super.key});

  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  late final StreamSubscription<List<ConnectivityResult>> subscription;
  bool hasInternet = false;
  late final WebViewController _controller;
  bool _webViewInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse('https://tambay.co'));
    _checkConnection();
    subscription = Connectivity().onConnectivityChanged.listen((results) {
      final connected = results.any(
        (result) => result != ConnectivityResult.none,
      );
      if (connected && !hasInternet && _webViewInitialized) {
        // If internet is restored, reload the page
        _controller.reload();
      }
      setState(() {
        hasInternet = connected;
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
      return Scaffold(
        body: SafeArea(child: WebViewWidget(controller: _controller)),
      );
    } else {
      return const NoInternetScreen();
    }
  }
}
