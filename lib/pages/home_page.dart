import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/term_use.dart';
import 'package:flutter_application_2/widgets/bubble.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key, required this.title});

// textField랑 animation도 다음에 같이 쓰면 좋겠다.
// floatingActionButton == float button
// bottomNavigationBar == footer
// appBar == haeder
// body == body
// safety area: 노치, 홈 인디케이터 등과 겹치지 않도록 해주는 위젯
// w(디바이스가로), h(디바이스세로), sp(폰트사이즈), r(border radius) 단위로 
// const 이면 유동적으로 변하지 않으므로 flutter_screenutil 사용 불가

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
            circleBubble(message: '우리 동네에는 어떤 월리가 있을까요?'),
            const SizedBox(height: 20),
            // 3. 카카오 로그인 버튼
            _buildLoginButton(
              text: '카카오 로그인',
              backgroundColor: const Color(0xFFFFE812),
              textColor: Colors.black,
              icon: Icons.chat_bubble, // 카카오 로고 대신 기본 아이콘 사용
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpTermsScreen()),
                );
                // 카카오 로그인 로직 구현
                // showAlert(context,
                //   title: '에러',
                //   message: '로그인에 실패했습니다.',
                // );
              },
            ),
            const SizedBox(height: 12),
            // 4. 휴대폰 로그인 버튼
            _buildLoginButton(
              text: '휴대폰 로그인',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              icon: Icons.phone_android,
              borderColor: Colors.grey.shade300,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpTermsScreen()),
                );
                // 휴대폰 로그인 로직 구현
              },
            ),
            const SizedBox(height: 12),
            // 5. Apple 로그인 버튼
            _buildLoginButton(
              text: 'Apple 로그인',
              backgroundColor: const Color(0xFF2E2E2E),
              textColor: Colors.white,
              icon: Icons.apple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpTermsScreen()),
                );
                // Apple 로그인 로직 구현
              },
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
    required VoidCallback onTap, // 터치 콜백
    Color? borderColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
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
        )
      ),
    );
  }
}
