import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';
import 'package:won/model/model_register.dart';
import 'package:won/model/model_register_provider.dart';

class ModifyUserinfo extends StatefulWidget {
  const ModifyUserinfo({super.key});

  @override
  State<ModifyUserinfo> createState() => _ModifyRequestState();
}

class _ModifyRequestState extends State<ModifyUserinfo> {
  TextEditingController ZipController = TextEditingController();
  TextEditingController Address1Controller = TextEditingController();
  TextEditingController Address2Controller = TextEditingController();
  String Name = "";
  String User = "";
  String Birthday = "";
  String Nickname = "";
  String PhoneNumber = "";
  String AddressZip = "";
  String Address1 = "";
  String Address2 = "";

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
                title: Text("개인정보 수정"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Text("회원 : "),
                          Text(userinfo.user + " 회원"),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Text("이름 : "),
                          Text(userinfo.name),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Text("email : "),
                          Text(userinfo.email),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Text("생년월일 : "),
                          Text(userinfo.birthday),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Text("닉네임 : "),
                          Expanded(
                            child: TextFormField(
                              initialValue: userinfo.nickname,
                              onChanged: (value) {
                                Nickname = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Text("전화번호 : "),
                          Expanded(
                            child: TextFormField(
                              initialValue: userinfo.phoneNumber,
                              onChanged: (value) {
                                PhoneNumber = value;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                NumberFormatter(),
                                LengthLimitingTextInputFormatter(13),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("주소"),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: ZipController,
                                    readOnly: true,
                                    decoration:
                                        InputDecoration(hintText: "우편번호"),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                FilledButton(
                                  onPressed: () {
                                    setState(() {
                                      ZipController.text = userinfo.addressZip;
                                      Address1Controller.text =
                                          userinfo.address1;
                                      Address2Controller.text =
                                          userinfo.address2;
                                      AddressZip = userinfo.addressZip;
                                      Address1 = userinfo.address1;
                                      Address2 = userinfo.address2;
                                    });
                                  },
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    child: Text("기존 주소"),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                FilledButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return KpostalView(
                                          callback: (Kpostal result) {
                                            ZipController.text =
                                                result.postCode;
                                            Address1Controller.text =
                                                result.address;
                                            AddressZip = result.postCode;
                                            Address1 = result.address;
                                          },
                                        );
                                      },
                                    ));
                                  },
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    child: Text("새 주소"),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: Address1Controller,
                              readOnly: true,
                              decoration: InputDecoration(hintText: "도로명 주소"),
                            ),
                            TextFormField(
                              controller: Address2Controller,
                              onChanged: (value) {
                                Address2 = value;
                              },
                              decoration: InputDecoration(
                                labelText: '상세주소',
                              ),
                            ),
                          ],
                        )),
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
                        child: Text('변경하기'),
                        onPressed: () {
                          PhoneNumber = PhoneNumber == ""
                              ? userinfo.phoneNumber
                              : PhoneNumber;
                          Nickname =
                              Nickname == "" ? userinfo.nickname : Nickname;
                          Register newregister = Register(
                            user: userinfo.user,
                            name: userinfo.name,
                            email: userinfo.email,
                            birthday: userinfo.birthday,
                            phoneNumber: PhoneNumber,
                            address1: Address1,
                            address2: Address2,
                            addressZip: AddressZip,
                            nickname: Nickname,
                            reference: userinfo.reference,
                          );
                          registerProvider
                              .updateRegister(newregister)
                              .then((value) {
                            Navigator.of(context).pop();
                          });
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

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-');
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
