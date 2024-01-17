import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:won/model/request/model_request_provider.dart';
import '../model/model_register.dart';
import '../model/model_register_provider.dart';

class RequestTab extends StatefulWidget {
  const RequestTab({super.key});

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return FutureBuilder(
      future: RegisterProvider().getUserInfo(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Register userinfo = snapshot.data!;
          return FutureBuilder(
              future: requestProvider.fetchItems(userinfo),
              builder: (BuildContext context, snapshot) {
                if (requestProvider.requests.length == 0) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('요청 내역'),
                    ),
                    body: Center(
                      child: Text("요청 내역이 없습니다."),
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.pushNamed(context, '/sendrequest');
                        },
                        label: Text('요청하기')),
                  );
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('요청 내역'),
                    ),
                    body: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(requestProvider.requests[index].name),
                          onTap: () {
                            Navigator.pushNamed(context, '/showrequest',
                                arguments: requestProvider.requests[index]);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: requestProvider.requests.length,
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sendrequest');
                      },
                      label: Text('요청하기'),
                    ),
                  );
                }
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
