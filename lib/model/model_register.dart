import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Register extends ChangeNotifier {
  late String pw;
  late String pwConfirm;
  late String user;
  late String name;
  late String birthday;
  late String nickname;
  late String phoneNumber;
  late String email;
  late String addressZip;
  late String address1;
  late String address2;
  late DocumentReference? reference;

  Register({
    required this.name,
    required this.user,
    required this.birthday,
    required this.nickname,
    required this.phoneNumber,
    required this.email,
    required this.addressZip,
    required this.address1,
    required this.address2,
    this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'user': user,
      'birthday': birthday,
      'nickname': nickname,
      'phoneNumber': phoneNumber,
      'email': email,
      'addressZip': addressZip,
      'address1': address1,
      'address2': address2,
    };
  }

  // Register.fromMap(Map<dynamic, dynamic>? map) {
  //   name = map?['name'];
  //   user = map?['user'];
  //   birthday = map?['birthday'];
  //   nickname = map?['nickname'];
  //   phoneNumber = map?['phoneNumber'];
  //   email = map?['email'];
  //   addressZip = map?['addressZip'];
  //   address1 = map?['address1'];
  //   address2 = map?['address2'];
  // }

  Register.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    name = map['name'];
    user = map['user'];
    birthday = map['birthday'];
    nickname = map['nickname'];
    phoneNumber = map['phoneNumber'];
    email = map['email'];
    addressZip = map['addressZip'];
    address1 = map['address1'];
    address2 = map['address2'];
    reference = document.reference;
  }
}
