import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_map/network/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_map/home.dart';
import 'package:google_map/navigationbar.dart';
import 'package:google_map/diary/pages/diary.dart';
import 'package:google_map/diary/pages/edit.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'diary/data/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:logger/logger.dart';

import 'package:google_map/settings/deletepage.dart';
import 'package:google_map/settings/errorpage.dart';
import 'package:google_map/settings/fontpage.dart';
import 'package:google_map/settings/logoutpage.dart';
import 'package:google_map/settings/noticepage.dart';
import 'package:google_map/settings/optionpage.dart';
import 'package:google_map/settings/questionpage.dart';
import 'package:google_map/settings/themepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_map/planner/pages/home_page.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';


void main() async{
  // init the hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('mybox');

  await initializeDateFormatting();
  runApp(const ProviderScope(child: MyApp(),
  ));
  DependencyInjection.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate, // 텍스트 현지화
        GlobalWidgetsLocalizations.delegate, // 텍스트 방향 현지화
      ],
      supportedLocales: [
        const Locale('ko', 'KR'),
      ],
      locale: const Locale('ko', 'KR'),
      title: 'calendar',
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('다플'),
        elevation: 0.0,

      ),
      body: navigationbar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(''),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(''),
                ),
              ],
              accountName: Text('NAME'),
              accountEmail: Text('email@gmail.com'),
              onDetailsPressed:(){
                print('arrow is clicked');
              },
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('테마 색상'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>ThemePage()
                ));
                Navigator.pushNamed(context, '테마 색상');
                print('테마 색상 is clicked');
              },
            ),
            ListTile(
              leading: Icon(Icons.font_download),
              title: Text('폰트'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>FontPage()
                ));
                Navigator.pushNamed(context, '폰트');
                print('폰트 is clicked');
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark_sharp),
              title: Text('자주 묻는 질문'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>QuestionPage()
                ));
                Navigator.pushNamed(context, '자주 묻는 질문');
                print('자주 묻는 질문 is clicked');
              },
            ),
            ListTile(
              leading: Icon(Icons.error),
              title: Text('버그/오류 제보'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>ErrorPage()
                ));
                Navigator.pushNamed(context, '버그/오류 제보');
                print('버그/오류 제보 is clicked');
              },
            ),
            ListTile(
              leading: Icon(Icons.comment),
              title: Text('의견 보내기'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>OpinionPage()
                ));
                Navigator.pushNamed(context, '의견 보내기');
                print('의견 보내기 is clicked');
              },
            ),
            ListTile(
              leading: Icon(Icons.notification_add),
              title: Text('공지사항'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>NoticePage()
                ));
                Navigator.pushNamed(context, '공지사항');
                print('공지사항 is clicked');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('로그아웃'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>LogoutPage()
                ));
                Navigator.pushNamed(context, '로그아웃');
                print('로그아웃 is clicked');
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text('회원탈퇴'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>DeletePage()
                ));
                Navigator.pushNamed(context, '회원탈퇴');
                print('회원탈퇴 is clicked');
              },
            ),
          ],
        ),
      ),
    );
  }
}