import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 48),
              Text(
                'Login Page Body',
                style: TextStyle(
                  fontSize: 24,
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