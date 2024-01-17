import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'model_community.dart';

class CommunityProvider with ChangeNotifier {
  late CollectionReference CommunityReference;
  List<Community> communitys = [];

  CommunityProvider({reference}) {
    CommunityReference =
        reference ?? FirebaseFirestore.instance.collection('community');
  }

  Future<void> getCommunity() async {
    communitys = await CommunityReference.get().then((QuerySnapshot results) {
      return results.docs.map((DocumentSnapshot document) {
        return Community.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }

  Future addCommunity(Community community) async {
    CommunityReference.add(community.toMap());
  }

  Future updateCommunity(Community community) async {
    community.reference?.update(community.toMap());
  }

  Future deleteCommunity(Community community) async {
    community.reference?.delete();
  }
}
