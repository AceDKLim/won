import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:won/model/mypage/model_question_provider.dart';

import '../../model/model_register.dart';
import '../../model/model_register_provider.dart';

class ShowQuestion extends StatelessWidget {
  const ShowQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("1:1 문의"),
      ),
      body: FutureBuilder(
        future: RegisterProvider().getUserInfo(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Register userinfo = snapshot.data!;
          return FutureBuilder(
              future: questionProvider.getQuestion(userinfo),
              builder: (context, snapshot) {
                if (questionProvider.questions.length == 0) {
                  return Center(
                    child: Text("문의 내역이 없습니다."),
                  );
                }
                return (ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(questionProvider.questions[index].title),
                      trailing: Text(questionProvider.questions[index].date),
                      onTap: () {
                        Navigator.pushNamed(context, '/detailQuestion',
                            arguments: questionProvider.questions[index]);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: questionProvider.questions.length,
                ));
              });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/sendQuestion');
        },
        label: Text('요청하기'),
      ),
    );
  }
}
