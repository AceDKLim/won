import 'package:flutter/material.dart';
import 'package:won/model/mypage/model_auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String pw = "";
  String pwConfirm = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("비밀번호 변경"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextFormField(
              onChanged: (value) {
                pw = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              onChanged: (value) {
                pwConfirm = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                helperText: '',
              ),
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
              child: Text('비밀번호 변경'),
              onPressed: () async {
                if (pw == pwConfirm) {
                  try {
                    await FirebaseAuthProvider().changePW(pw);
                    await FirebaseAuthProvider().authClient.signOut();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text('비밀번호 변경에 성공했습니다.')),
                      );
                    Navigator.of(context).pushReplacementNamed('/login');
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text('비밀번호 변경에 실패했습니다.')),
                      );
                  }
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
