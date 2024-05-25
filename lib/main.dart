import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:dyscalculia_app/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 비동기 초기화가 필요한 경우 추가
  await initializeDateFormatting();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
