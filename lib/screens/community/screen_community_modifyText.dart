import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:won/model/community/model_community.dart';
import 'package:won/model/community/model_community_provider.dart';

class ModifyText extends StatefulWidget {
  const ModifyText({super.key});

  @override
  State<ModifyText> createState() => _ModifyTextState();
}

class _ModifyTextState extends State<ModifyText> {
  String Title = "";
  String Content = "";
  String Writer = "";
  bool Pick = false;
  String date = DateFormat("yyyy년 MM월 dd일 HH:mm").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);
    final community = ModalRoute.of(context)!.settings.arguments as Community;
    Writer = community.writer;
    return Scaffold(
      appBar: AppBar(
        title: Text(community.title),
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
                    child: TextFormField(
                      initialValue: community.title,
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
              child: TextFormField(
                initialValue: community.content,
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
                child: Text('수정하기'),
                onPressed: () {
                  Title = Title == "" ? community.title : Title;
                  Content = Content == "" ? community.content : Content;
                  Community newCommunity = Community(
                    email: community.email,
                    date: date,
                    writer: Writer,
                    title: Title,
                    content: Content,
                    pick: Pick,
                    reference: community.reference,
                  );
                  communityProvider.updateCommunity(newCommunity);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
