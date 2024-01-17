import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:won/model/mypage/model_question.dart';
import 'package:won/model/mypage/model_question_provider.dart';
import 'package:won/model/model_register.dart';
import 'package:won/model/model_register_provider.dart';

class SendQuestion extends StatefulWidget {
  const SendQuestion({super.key});

  @override
  State<SendQuestion> createState() => _SendQuestionState();
}

class _SendQuestionState extends State<SendQuestion> {
  DateTime dt = DateTime.now();
  String Title = "";
  String Detail = "";
  String date = DateFormat("yyyy년 MM월 dd일 HH:mm").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    return FutureBuilder(
        future: RegisterProvider().getUserInfo(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Register userinfo = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text("1:1 문의"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: TextFormField(
                        onChanged: (value) {
                          Title = value;
                        },
                        decoration: InputDecoration(labelText: '제목'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: TextFormField(
                        onChanged: (value) {
                          Detail = value;
                        },
                        decoration: InputDecoration(labelText: '내용'),
                        maxLines: 10,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text('요청하기'),
                        onPressed: () {
                          Question newQuestion = Question(
                              email: userinfo.email,
                              nickname: userinfo.nickname,
                              title: Title,
                              date: date,
                              detail: Detail);
                          questionProvider.addQuestion(newQuestion);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
