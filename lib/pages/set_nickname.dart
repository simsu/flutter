import 'package:flutter/material.dart';

class NicknameSetupScreen extends StatefulWidget {
  const NicknameSetupScreen({super.key});

  @override
  State<NicknameSetupScreen> createState() => _NicknameSetupScreenState();
}

class _NicknameSetupScreenState extends State<NicknameSetupScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // 텍스트 입력 감지하여 버튼 활성화 상태 변경
    _nicknameController.addListener(() {
      setState(() {
        _isButtonEnabled = _nicknameController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '회원 가입',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            // 1. 헤더 타이틀 (RichText로 필수 표시 '*' 처리)
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                children: [
                  TextSpan(text: '닉네임을 생성해 주세요.'),
                  TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // 2. 보조 설명 문구
            const Text(
              '동네 이웃들과 소통할 새로운 닉네임을 생성해 주세요!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            // 3. 실명 활동 안내 (아이콘 + 텍스트)
            Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Color(0xFF6DBB90)),
                const SizedBox(width: 4),
                const Text(
                  '월리는 실명으로 활동해요!',
                  style: TextStyle(fontSize: 15, color: Color(0xFF6DBB90)),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // 4. 닉네임 입력 필드
            TextField(
              controller: _nicknameController,
              cursorColor: const Color(0xFF6DBB90),
              decoration: InputDecoration(
                hintText: '닉네임',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                suffixIcon: _nicknameController.text.isNotEmpty 
                ? IconButton(
                  onPressed: () {
                    _nicknameController.clear(); // 텍스트 삭제
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(2), // 테두리와 아이콘 사이 간격
                    child: Icon(
                      Icons.close, 
                      size: 18, 
                      color: Colors.grey[600],
                    ),
                  ),
                ) : null,
                // 입력창 아래 선 스타일 (기본)
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6DBB90), width: 1.5),
                ),
                // 입력창 클릭 시(포커스) 선 스타일
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6DBB90), width: 2.0),
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),

            const Spacer(),

            // 5. 다음 버튼 (키보드 위에 위치하게 됨)
            SafeArea(
              child: Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? () {
                    // 다음 화면 이동 로직
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6DBB90),
                    disabledBackgroundColor: const Color(0xFFE0E0E0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    '다음',
                    style: TextStyle(
                      color: _isButtonEnabled ? Colors.white : Colors.grey[600],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
