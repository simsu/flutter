import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/age_verify.dart';

class SignUpTermsScreen extends StatefulWidget {
  const SignUpTermsScreen({super.key});
  @override
  State<SignUpTermsScreen> createState() => _SignUpTermsScreenState();
}

class _SignUpTermsScreenState extends State<SignUpTermsScreen> {
  bool _isAllAgreed = false;
  bool _isServiceAgreed = false;
  bool _isPrivacyAgreed = false;
  bool _isMarketingAgreed = false;

  void _toggleAllAgreed(bool? value) {
    setState(() {
      _isAllAgreed = value ?? false;
      _isServiceAgreed = _isAllAgreed;
      _isPrivacyAgreed = _isAllAgreed;
      _isMarketingAgreed = _isAllAgreed;
    });
  }

  void _updateAllAgreedState() {
    setState(() {
      _isAllAgreed = _isServiceAgreed && _isPrivacyAgreed && _isMarketingAgreed;
    });
  }

  bool get _isNextButtonEnabled => _isServiceAgreed && _isPrivacyAgreed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // 현재 화면을 종료하고 이전 화면으로 이동
          },
        ),
        title: const Text('회원 가입', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 22, color: Colors.black, height: 1.4, fontWeight: FontWeight.w400),
                children: [
                  TextSpan(text: '만나서 반가워요! 🐶🐱\n'),
                  TextSpan(
                    text: '월리',
                    style: TextStyle(color: Color(0xFF6DBB90), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '와 함께 하기 위해\n'),
                  TextSpan(
                    text: '이용 약관',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '에 동의해 주세요!'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),

          // 1. 모두 동의 (밑줄 없음, 화살표 없음)
          _buildAgreeTile(
            title: '모두 동의해요',
            value: _isAllAgreed,
            color: const Color(0xFF6DBB90),
            fontWeight: FontWeight.bold,
            showArrow: false,
            showUnderline: false,
            onChanged: _toggleAllAgreed,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Divider(color: Color(0xFFEEEEEE), thickness: 1.5),
          ),

          // 2. 개별 약관들 (밑줄 있음, 화살표 있음)
          _buildAgreeTile(
            option: '(필수)',
            title: '서비스 이용약관',
            value: _isServiceAgreed,
            onChanged: (val) {
              setState(() => _isServiceAgreed = val!);
              _updateAllAgreedState();
            },
          ),
          _buildAgreeTile(
            option: '(필수)',
            title: '개인정보 처리방침',
            value: _isPrivacyAgreed,
            onChanged: (val) {
              setState(() => _isPrivacyAgreed = val!);
              _updateAllAgreedState();
            },
          ),
          _buildAgreeTile(
            option: '(선택)',
            title: '마케팅 활용방침',
            value: _isMarketingAgreed,
            onChanged: (val) {
              setState(() => _isMarketingAgreed = val!);
              _updateAllAgreedState();
            },
          ),
          const Spacer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical:10),
              child: Center(
                child: TextButton(
                  onPressed: _isNextButtonEnabled
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AgeVerificationScreen()),
                          );
                        }
                      : null,
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 65), // 버튼 높이 설정
                    backgroundColor: const Color(0xFF6DBB90), // 활성화 배경색
                    disabledBackgroundColor: const Color(0xFFE0E0E0), // 비활성화 배경색
                    foregroundColor: Colors.white, // 텍스트 색상
                    // 2. 평면적인 느낌을 위해 입체감(elevation) 제거
                    elevation: 0, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: const Text(
                    '다음',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreeTile({
    required String title,
    required bool value,
    String? option,
    FontWeight? fontWeight,
    double fontSize = 16,
    Color? color,
    bool showUnderline = true, // 밑줄 여부 기본값 true
    bool showArrow = true,      // 화살표 여부 기본값 true
    required ValueChanged<bool?> onChanged,
  }) {
    final textColor = color ?? Colors.grey[600]!;

    return ListTile(
      onTap: () => onChanged(!value),
      leading: Transform.scale(
      scale: 1.3,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF6DBB90),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        shape: const CircleBorder(), // 요청하신 원형으로 변경
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      horizontalTitleGap: 0, // 체크박스와 텍스트 사이 간격 좁힘
      title: Row(
        children: [
          if (option != null) ...[
            Text(
              option,
              style: TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontWeight),
            ),
            const SizedBox(width: 4),
          ],
          Container(
            decoration: showUnderline
                ? BoxDecoration(
                    border: Border(bottom: BorderSide(color: textColor, width: 0.8)),
                  )
                : null,
            child: Text(
              title,
              style: TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontWeight),
            ),
          ),
        ],
      ),
      trailing: showArrow 
          ? const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey) 
          : null,
    );
  }
}
