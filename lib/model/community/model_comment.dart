import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  late String email;
  late String nickname;
  late String content;
  late String date;
  late DocumentReference? reference;

  Comment({
    required this.email,
    required this.nickname,
    required this.content,
    required this.date,
    this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nickname': nickname,
      'content': content,
      'date': date,
    };
  }

  // Comment.fromMap(Map<dynamic, dynamic>? map) {
  //   email = map?['email'];
  //   nickname = map?['nickname'];
  //   content = map?['content'];
  //   date = map?['date'];
  // }

  Comment.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    email = map['email'];
    nickname = map['nickname'];
    content = map['content'];
    date = map['date'];
    reference = document.reference;
  }
}
