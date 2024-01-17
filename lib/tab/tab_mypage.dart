import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/mypage/model_auth.dart';
import '../model/model_register.dart';
import '../model/model_register_provider.dart';

class MyPageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient =
        Provider.of<FirebaseAuthProvider>(context, listen: false);
    return FutureBuilder(
        future: RegisterProvider().getUserInfo(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Register userinfo = snapshot.data!;
            return Scaffold(
              appBar: AppBar(title: Text("MyPage")),
              body: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('이름 : ' + userinfo.name),
                        Text("등급 : level" + "1"),
                        Text("현재 기부한 옷 : "),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: ((context) => AlertDialog(
                                    title: Text("등급 안내"),
                                    content: Text("내용"),
                                  )),
                            );
                          },
                          child: Text("등급 안내"),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Text("고객센터"),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/oftenQuestion');
                          },
                          child: Text("자주하는 질문")),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/showQuestion');
                          },
                          child: Text("1:1 문의")),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/userinfo');
                          },
                          child: Text("개인 정보")),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/modifyuser');
                          },
                          child: Text("개인 정보 수정")),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/changePW');
                          },
                          child: Text("비밀번호 변경")),
                      TextButton(
                        onPressed: () async {
                          await authClient.logout();
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(content: Text('로그아웃 되었습니다.')),
                            );
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: Text('로그아웃'),
                      ),
                    ],
                  ),
                ],
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
