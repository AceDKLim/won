import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kpostal/kpostal.dart';
import 'package:won/model/model_register.dart';
import 'package:won/model/model_register_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterProvider registerProvider = RegisterProvider();
  TextEditingController BirthdayController = TextEditingController();
  TextEditingController ZipController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  String Address1 = '';
  String address2 = '';
  String addressZip = '';
  String birthday = '';
  String email = '';
  String name = '';
  String nickname = '';
  String phoneNumber = '';
  String user = '';
  String pw = '';
  String pwConfirm = '';
  List<bool> selections = [false, false];
  final authentication = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    setState(() {
      registerProvider.initDb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            ToggleButtons(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Column(
                    children: [
                      Icon(Icons.people),
                      Text('개인 회원', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Column(
                    children: [
                      Icon(Icons.business),
                      Text('기업 회원', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ],
              isSelected: selections,
              onPressed: (index) {
                setState(() {
                  if (index == 0) {
                    selections[0] = true;
                    selections[1] = false;
                    user = "개인";
                  } else {
                    selections[0] = false;
                    selections[1] = true;
                    user = "기업";
                  }
                });
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(labelText: '이름'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                onChanged: (value) {
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: '이메일',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                onChanged: (value) {
                  nickname = value;
                },
                decoration: InputDecoration(
                  labelText: '닉네임',
                  helperText: '',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextFormField(
                onChanged: (value) {
                  pw = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  errorText:
                      pw.length < 6 && pw.isNotEmpty ? '비밀번호가 너무 짧습니다.' : null,
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
                  errorText: pw != pwConfirm ? '비밀번호가 일치하지 않습니다' : null,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                onChanged: (value) {
                  phoneNumber = value;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  NumberFormatter(),
                  LengthLimitingTextInputFormatter(13),
                ],
                decoration: InputDecoration(
                  labelText: '전화번호',
                  helperText: '',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          String Birthday =
                              DateFormat('yyyy/MM/dd').format(selectedDate);
                          birthday = Birthday;
                          BirthdayController.text = Birthday;
                        });
                      }
                    },
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: BirthdayController,
                    decoration: InputDecoration(hintText: '생년월일'),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ZipController,
                            readOnly: true,
                            decoration: InputDecoration(hintText: "우편번호"),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return KpostalView(
                                  callback: (Kpostal result) {
                                    ZipController.text = result.postCode;
                                    AddressController.text = result.address;
                                    addressZip = result.postCode;
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
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text("우편 번호 찾기"),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: AddressController,
                      readOnly: true,
                      decoration: InputDecoration(hintText: "도로명 주소"),
                    ),
                    TextField(
                      onChanged: (value) {
                        address2 = value;
                      },
                      decoration: InputDecoration(
                        labelText: '상세주소',
                        helperText: '',
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
                child: Text('회원가입'),
                onPressed: () async {
                  Register newRegister = Register(
                    name: name,
                    user: user,
                    birthday: birthday,
                    nickname: nickname,
                    phoneNumber: phoneNumber,
                    email: email,
                    addressZip: addressZip,
                    address1: Address1,
                    address2: address2,
                  );
                  try {
                    final newUser =
                        await authentication.createUserWithEmailAndPassword(
                            email: email, password: pw);
                    if (newUser.user != null) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text('회원가입에 성공했습니다.')),
                        );
                      await FirebaseFirestore.instance
                          .collection("UserInformation")
                          .doc(newUser.user!.uid)
                          .set(newRegister.toMap())
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    }
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text('회원가입에 실패 했습니다.')),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
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
