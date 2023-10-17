import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_challenge/authentication/view_models/signup_view_model.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = "signup";
  static const routeURL = "/signup";
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    ref.read(signUpForm.notifier).state = {"email": _email};
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "password": _password};
    ref.read(signUpProvider.notifier).signUp();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
                  color: Colors.cyan,
                ),
                child: const Center(child: Text("Sign Up")),
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
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
