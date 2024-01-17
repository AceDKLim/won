import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:won/model/mypage/model_question.dart';
import 'package:won/model/mypage/model_question_provider.dart';

class DetailQuestion extends StatelessWidget {
  const DetailQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    final question = ModalRoute.of(context)!.settings.arguments as Question;
    return Scaffold(
      appBar: AppBar(
        title: Text(question.title),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '작성자 : ' + question.nickname.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '이메일 : ' + question.email.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '날짜 : ' + question.date.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '제목 : ' + question.title.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '문의 내용 : ' + question.detail.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text('삭제하기'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: ((BuildContext context) => AlertDialog(
                        title: Text("요청 삭제"),
                        content: Text('요청을 삭제하시겠습니까?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                questionProvider
                                    .deleteQuestion(question)
                                    .then((value) {
                                  Navigator.of(context).pop();
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('네')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('아니오')),
                        ],
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
