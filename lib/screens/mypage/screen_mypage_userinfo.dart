import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:won/model/model_register.dart';
import 'package:won/model/model_register_provider.dart';

class ShowUserInfo extends StatefulWidget {
  const ShowUserInfo({super.key});

  @override
  State<ShowUserInfo> createState() => _ShowUserInfoState();
}

class _ShowUserInfoState extends State<ShowUserInfo> {
  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    return FutureBuilder(
        future: registerProvider.getUserInfo(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Register userinfo = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text("개인정보"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text("회원 : " + userinfo.user + " 회원"),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text("이름 : " + userinfo.name),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text("이메일 : " + userinfo.email),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text("닉네임 : " + userinfo.nickname),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text("전화번호 : " + userinfo.phoneNumber),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Text(
                        '주소 : ' +
                            userinfo.addressZip.toString() +
                            " " +
                            userinfo.address1.toString() +
                            " " +
                            userinfo.address2.toString(),
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
