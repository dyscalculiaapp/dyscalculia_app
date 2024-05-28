import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dyscalculia_app/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  SystemChrome.setPreferredOrientations([ // 스마트폰 가로 방향으로 회전 시 어플리케이션이 돌아가는 것 방지. 항상 세로 방향으로 작동하게 고정함.
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit( // 스마트폰 화면 사이즈에 따라 버튼, 텍스트 등의 크기가 조절되게 함.
      designSize: Size(410.4, 912),
      builder: (context, child) {
        return MaterialApp(
          title: 'ScreenUtil Test',
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        );
      },
    );
  }
}
