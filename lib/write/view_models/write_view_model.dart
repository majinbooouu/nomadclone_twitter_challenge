import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_challenge/authentication/repos/authentication_repo.dart';
import 'package:twitter_clone_challenge/write/models/write_model.dart';
import 'package:twitter_clone_challenge/write/repos/write_repo.dart';

class WritePostNotifier extends AsyncNotifier<void> {
  late final WriteRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.watch(writeRepo);
  }

  Future<void> uploadPost(String description, int emojiIndex) async {
    // final user = ref.read(authRepoProvider).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.savePost(
        WriteModel(
            description: description,
            creatorUid: ref.read(authRepo).user!.uid,
            creator: "anonymous",
            createdAt: DateTime.now().millisecondsSinceEpoch,
            skillIndex: emojiIndex),
      );
    });
  }
}

final writePostProvider = AsyncNotifierProvider<WritePostNotifier, void>(
  () => WritePostNotifier(),
);
