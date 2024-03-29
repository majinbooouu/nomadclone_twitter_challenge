import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_challenge/authentication/repos/authentication_repo.dart';
import 'package:twitter_clone_challenge/authentication/views/login_screen.dart';
import 'package:twitter_clone_challenge/authentication/views/signup_screen.dart';
import 'package:twitter_clone_challenge/main_navigation_screen.dart';

final routerProvider = Provider((ref) {
  ref.watch(authState);
  final isLoggedIn = ref.read(authRepo).isLoggedIn;
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      if (!isLoggedIn) {
        if (state.matchedLocation != SignUpScreen.routeURL &&
            state.matchedLocation != SignUpScreen.routeURL) {
          return LoginScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: LoginScreen.routeURL,
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: SignUpScreen.routeURL,
        name: SignUpScreen.routeName,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: "/:tab(home|write)",
        name: MainNavScreen.routeName,
        builder: (context, state) {
          final tab = state.pathParameters["tab"]!;
          return MainNavScreen(tab: tab);
        },
      ),
      // GoRoute(
      //   path: "/:tab(home|search|activity|profile)",
      //   name: MainNavigationScreen.routeName,
      //   builder: (context, state) {
      //     final tab = state.pathParameters["tab"]!;
      //     return MainNavigationScreen(tab: tab);
      //   },
      // ),
    ],
  );
});
