import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'model_question.dart';
import '../model_register.dart';

class QuestionProvider with ChangeNotifier {
  late CollectionReference QuestionReference;
  List<Question> questions = [];

  QuestionProvider({reference}) {
    QuestionReference =
        reference ?? FirebaseFirestore.instance.collection('questions');
  }

  Future<void> getQuestion(Register user) async {
    if (user.user == "기업") {
      questions = await QuestionReference.get().then((QuerySnapshot results) {
        return results.docs.map((DocumentSnapshot document) {
          return Question.fromSnapshot(document);
        }).toList();
      });
      notifyListeners();
    } else if (user.user == "개인") {
      questions = await QuestionReference.where("email", isEqualTo: user.email)
          .get()
          .then((QuerySnapshot results) {
        return results.docs.map((DocumentSnapshot document) {
          return Question.fromSnapshot(document);
        }).toList();
      });
      notifyListeners();
    }
  }

  Future addQuestion(Question question) async {
    QuestionReference.add(question.toMap());
  }

  Future updateQuestion(Question question) async {
    question.reference?.update(question.toMap());
  }

  Future deleteQuestion(Question question) async {
    question.reference?.delete();
  }
}
