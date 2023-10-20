import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_challenge/write/models/write_model.dart';

class WriteRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // upload a photo file
  UploadTask uploadPhotoFile(File photo, String uid) {
    final fileRef = _storage.ref().child(
          "/photos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}",
        );
    return fileRef.putFile(photo);
  }

  // create a post document
  Future<void> savePost(WriteModel data) async {
    try {
      await _db.collection("posts").add(data.toJson());
      print("Post saved successfully.");
    } catch (e) {
      print("Error saving post: $e");
    }
  }

  // 모든 포스트 시간 순으로 받아오는 함수
  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts() {
    return _db.collection("posts").orderBy("createdAt", descending: true).get();
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

final writeRepo = Provider((ref) => WriteRepository());
