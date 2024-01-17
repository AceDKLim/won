import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  late String email;
  late String num;
  late String name;
  late String phone;
  late String addressZip;
  late String address1;
  late String address2;
  late String cnt;
  late String detail;
  late DocumentReference? reference;

  Request({
    required this.email,
    required this.num,
    required this.name,
    required this.phone,
    required this.addressZip,
    required this.address1,
    required this.address2,
    required this.cnt,
    required this.detail,
    this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'num': num,
      'name': name,
      'phone': phone,
      'addressZip': addressZip,
      'address1': address1,
      'address2': address2,
      'cnt': cnt,
      'detail': detail,
    };
  }

  // Request.fromMap(Map<dynamic, dynamic>? map) {
  //   email = map?['email'];
  //   num = map?['num'];
  //   name = map?['name'];
  //   phone = map?['phone'];
  //   addressZip = map?['addressZip'];
  //   address1 = map?['address1'];
  //   address2 = map?['address2'];
  //   cnt = map?['cnt'];
  //   detail = map?['detail'];
  // }

  Request.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    email = map['email'];
    num = map['num'];
    name = map['name'];
    phone = map['phone'];
    addressZip = map['addressZip'];
    address1 = map['address1'];
    address2 = map['address2'];
    cnt = map['cnt'];
    detail = map['detail'];
    reference = document.reference;
  }
}
