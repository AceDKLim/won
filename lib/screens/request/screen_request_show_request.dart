import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:won/model/request/model_request.dart';

import '../../model/request/model_request_provider.dart';

class ShowRequest extends StatelessWidget {
  const ShowRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    final request = ModalRoute.of(context)!.settings.arguments as Request;
    return Scaffold(
      appBar: AppBar(
        title: Text(request.email),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '수거 번호 : ' + request.num.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '이름 : ' + request.name.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '전화 번호 : ' + request.phone.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '주소 : ' +
                  request.addressZip.toString() +
                  " " +
                  request.address1.toString() +
                  " " +
                  request.address2.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '수량 : ' + request.cnt.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              '상세 내용 : ' + request.detail.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
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
                    Navigator.pushNamed(context, '/modifyrequest',
                        arguments: request);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
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
                              title: Text("요청 삭제"),
                              content: Text('요청을 삭제하시겠습니까?'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      requestProvider
                                          .deleteRequest(request)
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
                            )));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
