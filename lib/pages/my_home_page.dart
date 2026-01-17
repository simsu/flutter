import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100), // 상단 여백
            // 1. 메인 타이틀 텍스트
            const Text(
              '우리 동네 이웃 월리,\n내 반려동물의 친구가 되다.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5DB58B), // 이미지와 유사한 초록색 계열
                height: 1.4,
              ),
            ),
            const Spacer(), // 중간 공간을 가득 채워 버튼을 아래로 밀어냄
            // 2. 말풍선 팁 (가운데 정렬을 위해 Center 사용)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5EE), // 연한 민트색 배경
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '우리 동네에는 어떤 월리가 있을까요?',
                      style: TextStyle(color: Color(0xFF65958A), fontSize: 14),
                    ),
                  ),
                  CustomPaint(
                    size: const Size(15, 10), // 삼각형의 너비와 높이 설정
                    painter: TrianglePainter(color: const Color(0xFFE8F5EE)),
                  )
                ],
              )
            ),
            const SizedBox(height: 20),
            // 3. 카카오 로그인 버튼
            _buildLoginButton(
              text: '카카오 로그인',
              backgroundColor: const Color(0xFFFFE812),
              textColor: Colors.black,
              icon: Icons.chat_bubble, // 카카오 로고 대신 기본 아이콘 사용
            ),
            const SizedBox(height: 12),
            // 4. 휴대폰 로그인 버튼
            _buildLoginButton(
              text: '휴대폰 로그인',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              icon: Icons.phone_android,
              borderColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),
            // 5. Apple 로그인 버튼
            _buildLoginButton(
              text: 'Apple 로그인',
              backgroundColor: const Color(0xFF2E2E2E),
              textColor: Colors.white,
              icon: Icons.apple,
            ),
            const SizedBox(height: 60), // 하단 여백
          ],
        ),
      ),
    );
  }

  // 버튼을 만드는 공통 위젯 함수
  // 생성자를 만들어서 final로 만들면 컴파일러한테 상수로 넘겨 주어서 더 효율적이다.
  Widget _buildLoginButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required IconData icon,
    Color? borderColor,
  }) {
    return Container(
      width: double.infinity, // 가로 꽉 채우기
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Stack( // 아이콘은 왼쪽, 텍스트는 중앙에 배치하기 위해 Stack 사용
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 20,
            child: Icon(icon, color: textColor),
          ),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


// 삼각형을 그리는 커스텀 페인터 클래스
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill; // 안을 채움

    final path = Path();
    // 삼각형 그리기 시작
    path.moveTo(size.width / 2, size.height); // 1. 하단 중앙 지점 (꼭짓점)
    path.lineTo(0, 0);                         // 2. 좌측 상단 지점
    path.lineTo(size.width, 0);                // 3. 우측 상단 지점
    path.close();                             // 시작점으로 돌아가 닫기

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}