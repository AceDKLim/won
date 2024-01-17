import 'dart:io';
import 'package:won/keys.env';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import 'package:won/model/mypage/model_auth.dart';
import 'package:won/model/community/model_community_provider.dart';
import 'package:won/model/request/model_request_provider.dart';
import 'package:won/screens/community/screen_community_modifyText.dart';
import 'package:won/screens/map/screen_map_viewList.dart';
import 'package:won/screens/mypage/screen_mypage_changePassword.dart';
import 'package:won/screens/mypage/screen_mypage_detailQuestion.dart';
import 'package:won/screens/mypage/screen_mypage_modifyUserinfo.dart';
import 'package:won/screens/mypage/screen_mypage_oftenQuestion.dart';
import 'package:won/screens/mypage/screen_mypage_sendQuestion.dart';
import 'package:won/screens/mypage/screen_mypage_showQuestion.dart';
import 'package:won/screens/mypage/screen_mypage_userinfo.dart';
import 'package:won/screens/screen_index.dart';
import 'package:won/screens/screen_login.dart';
import 'package:won/screens/request/screen_request_modify_request.dart';
import 'package:won/screens/screen_register.dart';
import 'package:won/screens/request/screen_request_send_request.dart';
import 'package:won/screens/community/screen_community_showText.dart';
import 'package:won/screens/request/screen_request_show_request.dart';
import 'package:won/screens/screen_splash.dart';
import 'package:won/screens/community/screen_community_writeText.dart';
import 'model/mypage/model_question_provider.dart';
import 'model/model_register_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: "NaverMapSdk_clientId",
      onAuthFailed: (ex) {
        print("********* 네이버맵 인증오류 : $ex *********");
      });
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'Firebase_apiKey',
              appId: 'Firebase_apiID',
              messagingSenderId: 'Firebase_messagingSenderId',
              projectId: 'Firebase_projectId'))
      : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => CommunityProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
      ],
      child: MaterialApp(
        title: 'App',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/index': (context) => IndexScreen(),
          '/register': (context) => RegisterScreen(),
          '/showrequest': (context) => ShowRequest(),
          '/sendrequest': (context) => SendRequest(),
          '/modifyrequest': (context) => ModifyRequest(),
          '/writeText': (context) => WriteText(),
          '/showText': (context) => ShowText(),
          '/modifyText': (context) => ModifyText(),
          '/userinfo': (context) => ShowUserInfo(),
          '/modifyuser': (context) => ModifyUserinfo(),
          '/changePW': (context) => ChangePassword(),
          '/oftenQuestion': (context) => OftenQuestion(),
          '/showQuestion': (context) => ShowQuestion(),
          '/detailQuestion': (context) => DetailQuestion(),
          '/sendQuestion': (context) => SendQuestion(),
          '/viewList': (context) => Viewlist(),
        },
        initialRoute: '/',
      ),
    );
  }
}
