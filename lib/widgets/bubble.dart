import 'package:flutter/material.dart';

Widget circleBubble({
  required String message,
}) {
  return Center(
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
  );
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
