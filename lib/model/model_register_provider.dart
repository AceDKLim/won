import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:won/model/model_register.dart';

class RegisterProvider with ChangeNotifier {
  late CollectionReference RegisterReference;
  late Stream<QuerySnapshot> RegisterStream;

  Future initDb() async {
    RegisterReference =
        FirebaseFirestore.instance.collection('UserInformation');
    RegisterStream = RegisterReference.snapshots();
  }

  Future<Register> getUserInfo() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection('UserInformation').doc(uid);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await documentReference.get();
    Register register = Register.fromSnapshot(documentSnapshot);
    return register;
  }

  Future updateRegister(Register register) async {
    register.reference?.update(register.toMap());
  }

  Future deleteRegister(Register register) async {
    register.reference?.delete();
  }
}
