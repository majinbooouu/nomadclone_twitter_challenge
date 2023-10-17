import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_challenge/authentication/view_models/login_view_model.dart';
import 'package:twitter_clone_challenge/authentication/views/signup_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "signin";
  static const routeURL = "/signin";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = "";
  String _password = "";
  final bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    ref.read(loginProvider.notifier).login(
          _email,
          _password,
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _onSubmit,
                    child: const Text("Next"),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () => context.push(SignUpScreen.routeURL),
              child: const Text("creat account"),
            ),
          ],
        ),
      ),
    );
  }
}
