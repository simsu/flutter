import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
// textField랑 animation도 다음에 같이 쓰면 좋겠다.
class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton == float button
      // bottomNavigationBar == footer
      // appBar == haeder
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      // body == body
      // safety area: 노치, 홈 인디케이터 등과 겹치지 않도록 해주는 위젯
      body: SafeArea(
        child: Padding(
          // w(디바이스가로), h(디바이스세로), sp(폰트사이즈), r(border radius) 단위로 
          // const 이면 유동적으로 변하지 않으므로 flutter_screenutil 사용 불가
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 48.w),
              Text(
                'Login Page Body',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                  height: 1.4
                  )
              ),
              Spacer(),
            ]
          ),
        )
      )
    );
  }
}