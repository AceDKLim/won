import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:won/model/community/model_community_provider.dart';

class CommunityTab extends StatefulWidget {
  const CommunityTab({super.key});

  @override
  State<CommunityTab> createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab> {
  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);
    return FutureBuilder(
      future: communityProvider.getCommunity(),
      builder: (BuildContext context, snapshot) {
        if (communityProvider.communitys.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text('커뮤니티'),
            ),
            body: Center(child: CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, '/writeText');
                },
                label: Text('글쓰기')),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('커뮤니티'),
            ),
            body: Column(
              children: [
                Card(
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text("제목"),
                      ),
                    ),
                    Container(
                      width: 150,
                      alignment: Alignment.center,
                      child: Text("등록일"),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Text("작성자"),
                    ),
                  ]),
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: communityProvider.communitys.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 3,
                          mainAxisExtent: 65),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.black.withOpacity(0.3)),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/showText',
                                  arguments:
                                      communityProvider.communitys[index]);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      communityProvider.communitys[index].title,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    communityProvider.communitys[index].date,
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Text(
                                    communityProvider.communitys[index].writer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, '/writeText');
                },
                label: Text('글쓰기')),
          );
        }
      },
    );
  }
}
