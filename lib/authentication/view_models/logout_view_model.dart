import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_challenge/authentication/repos/authentication_repo.dart';

class LogoutVM extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> logout() async {
    await _repository.signOut();
  }
}

final logoutProvider = AsyncNotifierProvider<LogoutVM, void>(
  () => LogoutVM(),
);
