import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  LocationPermission permission = await Geolocator.requestPermission();
  Position positione = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return positione;
}

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('헌옷수거함 위치'),
      ),
      body: FutureBuilder(
          future: getLocation(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            Position position = snapshot.data!;
            return Stack(
              children: [
                Expanded(
                  child: NaverMap(
                    options: NaverMapViewOptions(
                      initialCameraPosition: NCameraPosition(
                          target: NLatLng(
                            position.latitude.toDouble(),
                            position.longitude.toDouble(),
                          ),
                          zoom: 10),
                    ),
                    onMapReady: (controller) {
                      print("네이버 맵 로딩됨!");
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/viewList');
                  },
                  icon: Icon(Icons.list),
                  iconSize: 50,
                )
              ],
            );
          }),
    );
  }
}
// class HomeTab extends StatelessWidget {
//   const HomeTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: ),);
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: Text('헌옷수거함 위치'),
//     //   ),
//     //   body: Stack(
//     //     children: [
//     //       Expanded(
//     //         child: NaverMap(
//     //           options: const NaverMapViewOptions(),
//     //           onMapReady: (controller) {
//     //             print("네이버 맵 로딩됨!");
//     //           },
//     //         ),
//     //       ),
//     //       IconButton(
//     //         onPressed: () {
//     //           Navigator.of(context).pushNamed('/viewList');
//     //         },
//     //         icon: Icon(Icons.list),
//     //         iconSize: 50,
//     //       )
//     //     ],
//     //   ),
//     // );
//   }
// }
