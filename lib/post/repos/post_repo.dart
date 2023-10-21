import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // 포스트 지우기
  Future<void> deletePost(String Id) async {
    try {
      _db.collection("posts").doc(Id).delete();
    } catch (e) {}
  }

  // 내용 검색 함수
  Future<QuerySnapshot<Map<String, dynamic>>> searchDescription(
      String searchText) {
    return _db
        .collection("posts")
        .where("description", isGreaterThanOrEqualTo: searchText)
        .where("description", isLessThanOrEqualTo: '$searchText\uf8ff')
        // .orderBy("createdAt", descending: true)
        .get();
  }
}

final postRepo = Provider((ref) => PostRepository());
