import 'dart:async';

import 'package:flutter/material.dart';

class OftenQuestion extends StatefulWidget {
  const OftenQuestion({super.key});

  @override
  State<OftenQuestion> createState() => _OftenQuestionState();
}

class _OftenQuestionState extends State<OftenQuestion> {
  @override
  Widget build(BuildContext context) {
    var question = [
      ["q1", "a1"],
      ["q2", "a2"],
      ["q3", "a3"],
      ["q4", "a4"],
    ];
    var userQuestion = [];
    final StreamController<int> userpick = StreamController();
    return Scaffold(
        appBar: AppBar(title: Text("자주 하는 질문")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              height: 320,
              child: ListView.builder(
                itemCount: question.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(0)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ElevatedButton(
                      child: Text(question[index][0]),
                      onPressed: () {
                        userpick.sink.add(index);
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
                child: StreamBuilder(
              stream: userpick.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  userQuestion.add([question[snapshot.data!.toInt()][0], true]);
                  userQuestion
                      .add([question[snapshot.data!.toInt()][1], false]);
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        return ChatBubble(
                            userQuestion[index][0], userQuestion[index][1]);
                      },
                      itemCount: userQuestion.length);
                } else {
                  return (Center(
                    child: Text(""),
                  ));
                }
              },
            )),
          ],
        ));
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.message, this.isMe, {super.key});

  final String message;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Colors.blue,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0)),
          ),
          width: 300,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(color: isMe ? Colors.black : Colors.white),
          ),
        ),
      ],
    );
  }
}
