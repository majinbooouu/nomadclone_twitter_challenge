import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_challenge/firebase_options.dart';
import 'package:twitter_clone_challenge/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: TwitterCloneChallenge(),
    ),
  );
}

class TwitterCloneChallenge extends ConsumerWidget {
  const TwitterCloneChallenge({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
        routerConfig: ref.watch(routerProvider),
        debugShowCheckedModeBanner: false,
        title: 'Twitter Clone Challenge',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ));
  }
}
