import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_challenge/authentication/repos/authentication_repo.dart';
import 'package:twitter_clone_challenge/post/models/post_model.dart';

final postStreamProvider = StreamProvider<List<PostModel>>((ref) async* {
  ref.watch(authState);
  final isLoggedIn = ref.read(authRepo).isLoggedIn;
  if (isLoggedIn) {
    // Firebase Firestore에서 글 목록을 가져와서 실시간으로 업데이트합니다.
    final firestore = FirebaseFirestore.instance;
    final query =
        firestore.collection('posts').orderBy('createdAt', descending: true);

    final Stream<QuerySnapshot> snapshots = query.snapshots();

    // 초기 데이터를 추가합니다.
    yield* snapshots.map((snapshot) {
      final List<PostModel> posts = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PostModel.fromJson(data, doc.reference);
      }).toList();

      return posts;
    });
  }
});
