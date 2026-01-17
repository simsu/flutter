import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'my_app.dart';

void main() {
  // 각종 SDK 초기화

  WidgetsFlutterBinding.ensureInitialized();

  // 화면 세로 고정
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800), // 디자인 사이즈 설정
      minTextAdapt: true, // 텍스트 최소 크기 고정
      splitScreenMode: true, // 필드 펼쳤을 때 화면 사이즈 다시 고정
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}
