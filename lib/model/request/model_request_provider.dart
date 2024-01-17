import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:won/model/model_register.dart';
import 'package:won/model/request/model_request.dart';

class RequestProvider with ChangeNotifier {
  late CollectionReference RequestsReference;
  List<Request> requests = [];

  RequestProvider({reference}) {
    RequestsReference =
        reference ?? FirebaseFirestore.instance.collection('request');
  }

  Future<void> fetchItems(Register user) async {
    if (user.user == "기업") {
      requests = await RequestsReference.get().then((QuerySnapshot results) {
        return results.docs.map((DocumentSnapshot document) {
          return Request.fromSnapshot(document);
        }).toList();
      });
      notifyListeners();
    } else if (user.user == "개인") {
      requests = await RequestsReference.where("email", isEqualTo: user.email)
          .get()
          .then((QuerySnapshot results) {
        return results.docs.map((DocumentSnapshot document) {
          return Request.fromSnapshot(document);
        }).toList();
      });
      notifyListeners();
    }
  }

  Future addRequest(Request request) async {
    RequestsReference.add(request.toMap());
  }

  Future updateRequest(Request request) async {
    request.reference?.update(request.toMap());
  }

  Future deleteRequest(Request request) async {
    request.reference?.delete();
  }
}
