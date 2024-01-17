import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  late String email;
  late String nickname;
  late String title;
  late String date;
  late String detail;
  late DocumentReference? reference;

  Question({
    required this.email,
    required this.nickname,
    required this.title,
    required this.date,
    required this.detail,
    this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nickname': nickname,
      'date': date,
      'title': title,
      'detail': detail,
    };
  }

  // Question.fromMap(Map<dynamic, dynamic>? map) {
  //   email = map?['email'];
  //   nickname = map?['nickname'];
  //   date = map?['date'];
  //   title = map?['title'];
  //   detail = map?['detail'];
  // }

  Question.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    email = map['email'];
    nickname = map['nickname'];
    date = map['date'];
    title = map['title'];
    detail = map['detail'];
    reference = document.reference;
  }
}
