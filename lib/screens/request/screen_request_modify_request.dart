import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';
import 'package:won/model/request/model_request_provider.dart';
import '../../model/request/model_request.dart';

class ModifyRequest extends StatefulWidget {
  const ModifyRequest({super.key});

  @override
  State<ModifyRequest> createState() => _ModifyRequestState();
}

class _ModifyRequestState extends State<ModifyRequest> {
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
    final request = ModalRoute.of(context)!.settings.arguments as Request;
    return Scaffold(
      appBar: AppBar(
        title: Text("수거 요청"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextFormField(
                onChanged: (value) {
                  CollctNo = value;
                },
                initialValue: request.num,
                decoration: InputDecoration(labelText: '수거번호'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextFormField(
                initialValue: request.name,
                onChanged: (value) {
                  Name = value;
                },
                decoration: InputDecoration(labelText: '이름'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextFormField(
                initialValue: request.phone,
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
                            decoration: InputDecoration(hintText: "우편번호"),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              ZipController.text = request.addressZip;
                              Address1Controller.text = request.address1;
                              Address2Controller.text = request.address2;
                              AddressZip = request.addressZip;
                              Address1 = request.address1;
                              Address2 = request.address2;
                            });
                          },
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text("기존 주소"),
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
                                    Address1Controller.text = result.address;
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
                            padding: EdgeInsets.symmetric(vertical: 15.0),
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
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextFormField(
                initialValue: request.cnt,
                onChanged: (value) {
                  Cnt = value;
                },
                decoration: InputDecoration(labelText: '수량'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextFormField(
                initialValue: request.detail,
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
                  CollctNo = CollctNo == "" ? request.num : CollctNo;
                  Name = Name == "" ? request.name : Name;
                  PhoneNumber = PhoneNumber == "" ? request.phone : PhoneNumber;
                  Cnt = Cnt == "" ? request.cnt : Cnt;
                  Detail = Detail == "" ? request.detail : Detail;

                  Request newRequest = Request(
                    num: CollctNo,
                    name: Name,
                    phone: PhoneNumber,
                    cnt: Cnt,
                    detail: Detail,
                    address1: Address1,
                    address2: Address2,
                    addressZip: AddressZip,
                    email: request.email,
                    reference: request.reference,
                  );
                  requestProvider.updateRequest(newRequest).then((value) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
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
