import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:won/model/community/model_community.dart';
import 'package:won/model/community/model_community_provider.dart';
import 'package:won/model/model_register.dart';
import 'package:won/model/model_register_provider.dart';

class WriteText extends StatefulWidget {
  const WriteText({super.key});

  @override
  State<WriteText> createState() => _WriteTextState();
}

class _WriteTextState extends State<WriteText> {
  DateTime dt = DateTime.now();
  String Title = "";
  String Content = "";
  String Writer = "";
  bool Pick = false;
  String date = DateFormat("yyyy년 MM월 dd일 HH:mm").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);
    return FutureBuilder(
        future: RegisterProvider().getUserInfo(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Register userinfo = snapshot.data!;
            Writer = userinfo.nickname;
            return Scaffold(
              appBar: AppBar(
                title: Text("커뮤니티"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Container(
                            child: Text("작성자"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Text(
                            Writer,
                            style: TextStyle(fontSize: 20),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Container(
                            child: Text("제목"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                Title = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text("내용"),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: TextField(
                        maxLines: 10,
                        onChanged: (value) {
                          Content = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Container(
                            child: Text("캠페인 설정"),
                          ),
                          Container(
                            child: Checkbox(
                              value: Pick,
                              onChanged: (value) {
                                setState(() {
                                  Pick = !Pick;
                                });
                              },
                            ),
                          ),
                        ],
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
                        child: Text('작성하기'),
                        onPressed: () {
                          Community newCommunity = Community(
                              email: userinfo.email,
                              date: date,
                              writer: Writer,
                              title: Title,
                              content: Content,
                              pick: Pick);
                          communityProvider.addCommunity(newCommunity);
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
