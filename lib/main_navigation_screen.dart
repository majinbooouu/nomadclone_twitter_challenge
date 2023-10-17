import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_challenge/authentication/view_models/logout_view_model.dart';

class MainNavScreen extends ConsumerStatefulWidget {
  static const routeName = "home";
  static const routeURL = "/home";
  const MainNavScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends ConsumerState<MainNavScreen> {
  void _onLogout() {
    ref.read(logoutProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MainNav"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _onLogout,
          child: const Text("Log Out"),
        ),
      ),
    );
  }
}
