import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:won/model/community/model_comment.dart';

class CommentProvider with ChangeNotifier {
  late CollectionReference CommentReference;
  List<Comment> comments = [];

  CommentProvider(communityId) {
    CommentReference = FirebaseFirestore.instance
        .collection("community/" + communityId + "/comment");
  }

  Future<void> getComment() async {
    comments = await CommentReference.get().then((QuerySnapshot results) {
      return results.docs.map((DocumentSnapshot document) {
        return Comment.fromSnapshot(document);
      }).toList();
    });
    // notifyListeners();
  }

  Future addComment(Comment comment) async {
    CommentReference.add(comment.toMap());
  }

  Future deleteComment(Comment comment) async {
    comment.reference?.delete();
  }
}
