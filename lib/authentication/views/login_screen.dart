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
            const SizedBox(
              width: 300,
              height: 300,
              child: Image(image: AssetImage("assets/images/bunker.webp")),
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
                      labelText: "Email",
                      hintText: "ex) happy@x.com",
                    ),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Set strong password",
                    ),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _passwordController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty
                        ? _onSubmit
                        : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: const Text("Next"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () => context.push(SignUpScreen.routeURL),
              child: Text(
                "Don't you have an account yet?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
