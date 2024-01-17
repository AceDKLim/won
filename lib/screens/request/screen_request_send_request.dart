import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';
import 'package:won/model/model_register_provider.dart';
import 'package:won/model/request/model_request_provider.dart';
import '../../model/model_register.dart';
import '../../model/request/model_request.dart';

class SendRequest extends StatefulWidget {
  const SendRequest({super.key});

  @override
  State<SendRequest> createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  TextEditingController ZipController = TextEditingController();
  TextEditingController Address1Controller = TextEditingController();
  TextEditingController Address2Controller = TextEditingController();
  String CollctNo = '';
  String Name = "";
  String PhoneNumber = "";
  String AddressZip = "";
  String Address1 = "";
  String Address2 = "";
  String Cnt = '';
  String Detail = '';

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return FutureBuilder<Register>(
        future: RegisterProvider().getUserInfo(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Register userinfo = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text("수거 요청"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: TextField(
                        onChanged: (value) {
                          CollctNo = value;
                        },
                        decoration: InputDecoration(labelText: '수거번호'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: TextFormField(
                        initialValue: userinfo.name,
                        onChanged: (value) {
                          Name = value;
                        },
                        decoration: InputDecoration(labelText: '이름'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                        decoration: InputDecoration(
                          labelText: '전화번호',
                        ),
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
                                    child: Text("내 주소"),
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
                                    child: Text("우편 번호 찾기"),
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
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: TextField(
                        onChanged: (value) {
                          Cnt = value;
                        },
                        decoration: InputDecoration(labelText: '수량'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: TextField(
                        onChanged: (value) {
                          Detail = value;
                        },
                        decoration: InputDecoration(labelText: '상세내용'),
                        maxLines: 6,
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
                        child: Text('요청하기'),
                        onPressed: () {
                          Name = Name == "" ? userinfo.name : Name;
                          PhoneNumber = PhoneNumber == ""
                              ? userinfo.phoneNumber
                              : PhoneNumber;
                          Request newRequest = Request(
                              num: CollctNo,
                              name: Name,
                              phone: PhoneNumber,
                              cnt: Cnt,
                              detail: Detail,
                              address1: Address1,
                              address2: Address2,
                              addressZip: AddressZip,
                              email: userinfo.email);
                          requestProvider.addRequest(newRequest);
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
