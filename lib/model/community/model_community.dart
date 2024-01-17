import 'package:cloud_firestore/cloud_firestore.dart';

class Community {
  late String email;
  late String date;
  late String writer;
  late String title;
  late String content;
  late bool pick;
  late DocumentReference? reference;

  Community({
    required this.email,
    required this.date,
    required this.writer,
    required this.title,
    required this.content,
    required this.pick,
    this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'date': date,
      'writer': writer,
      'title': title,
      'content': content,
      'pick': pick,
    };
  }

  // Community.fromMap(Map<dynamic, dynamic>? map) {
  //   email = map?['email'];
  //   date = map?['date'];
  //   writer = map?['writer'];
  //   title = map?['title'];
  //   content = map?['content'];
  //   pick = map?['pick'];
  // }

  Community.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    email = map['email'];
    date = map['date'];
    writer = map['writer'];
    title = map['title'];
    content = map['content'];
    pick = map['pick'];
    reference = document.reference;
  }
}
