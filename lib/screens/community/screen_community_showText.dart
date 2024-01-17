import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:won/model/community/model_comment.dart';
import 'package:won/model/community/model_community.dart';
import 'package:won/model/community/model_community_provider.dart';
import 'package:won/model/model_register_provider.dart';

import '../../model/community/model_comment_provider.dart';
import '../../model/model_register.dart';

class ShowText extends StatefulWidget {
  const ShowText({super.key});

  @override
  State<ShowText> createState() => _ShowTextState();
}

class _ShowTextState extends State<ShowText> {
  String comment = "";
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final community = ModalRoute.of(context)!.settings.arguments as Community;
    final commentProvider = CommentProvider(community.reference?.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(community.title),
      ),
      body: FutureBuilder(
        future: RegisterProvider().getUserInfo(),
        builder: (context, snapshot1) {
          if (!snapshot1.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Register userinfo = snapshot1.data!;
          return Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(children: [
                Container(
                  width: 200,
                  alignment: Alignment.center,
                  child: Text("제목"),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(community.title),
                  ),
                )
              ]),
              Row(children: [
                Container(
                  width: 200,
                  alignment: Alignment.center,
                  child: Text("작성자"),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(community.writer),
                  ),
                )
              ]),
              Row(children: [
                Container(
                  width: 200,
                  alignment: Alignment.center,
                  child: Text("작성 일시"),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(community.date),
                  ),
                )
              ]),
              SizedBox(
                height: 30,
              ),
              Text(community.content),
              community.email == userinfo.email
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text('수정하기'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/modifyText',
                                  arguments: community);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
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
                                      title: Text("게시글"),
                                      content: Text('게시글을 삭제하시겠습니까?'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              CommunityProvider()
                                                  .deleteCommunity(community)
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
                    )
                  : SizedBox(),
              Container(
                padding: EdgeInsets.all(50),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        onChanged: (value) {
                          comment = value;
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Comment newComment = Comment(
                              email: userinfo.email,
                              nickname: userinfo.nickname,
                              content: comment,
                              date: DateFormat("yyyy/MM/dd/ HH:mm")
                                  .format(DateTime.now()));
                          commentProvider.addComment(newComment);
                          setState(() {
                            commentController.text = "";
                          });
                        },
                        icon: Icon(Icons.send))
                  ],
                ),
              ),
              FutureBuilder(
                future: commentProvider.getComment(),
                builder: (BuildContext context, snapshot) {
                  if (commentProvider.comments.isEmpty) {
                    return Text("작성된 댓글이 없습니다");
                  } else {
                    return Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, index) {
                            if (commentProvider.comments[index].email ==
                                userinfo.email) {
                              return Card(
                                child: ListTile(
                                  title: Text(
                                      commentProvider.comments[index].nickname),
                                  subtitle: Text(
                                      commentProvider.comments[index].content),
                                  trailing: SizedBox(
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(commentProvider
                                            .comments[index].date),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: ((BuildContext
                                                          context) =>
                                                      AlertDialog(
                                                        title: Text("댓글 삭제"),
                                                        content: Text(
                                                            '댓글을 삭제하시겠습니까?'),
                                                        actions: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                commentProvider.deleteComment(
                                                                    commentProvider
                                                                            .comments[
                                                                        index]);
                                                                setState(() {});
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text('네')),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child:
                                                                  Text('아니오')),
                                                        ],
                                                      )));
                                            },
                                            icon: Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                  isThreeLine: true,
                                ),
                              );
                            } else {
                              return Card(
                                child: ListTile(
                                  title: Text(
                                      commentProvider.comments[index].nickname),
                                  subtitle: Text(
                                      commentProvider.comments[index].content),
                                  trailing: Text(
                                      commentProvider.comments[index].date),
                                  isThreeLine: true,
                                ),
                              );
                            }
                          },
                          itemCount: commentProvider.comments.length,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
