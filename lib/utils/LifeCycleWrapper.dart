import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LifeCycleCTRL extends StatefulWidget {
  final Widget child;

  const LifeCycleCTRL({Key? key, required this.child}) : super(key: key);

  @override
  _LifeCycleCTRLState createState() => _LifeCycleCTRLState();
}

class _LifeCycleCTRLState extends State<LifeCycleCTRL>
    with WidgetsBindingObserver {
  Timer? _logoutTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _logoutTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        print("App paused — starting logout timer...");
        _startLogoutTimer();
        break;
      case AppLifecycleState.resumed:
        print("App resumed — cancelling logout timer.");
        _cancelLogoutTimer();
        break;
      case AppLifecycleState.detached:
        print("App detached — cleaning up.");
        _logoutNow();
        break;
      default:
        break;
    }
  }

  void _startLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = Timer(Duration(seconds: 30), _logoutNow);
  }

  void _cancelLogoutTimer() {
    _logoutTimer?.cancel();
  }

  void _logoutNow() {
    print("Logging out user...");
    _logoutTimer?.cancel();

    // Example: clear session data and go to login screen
    // Replace this with your actual logout logic
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
