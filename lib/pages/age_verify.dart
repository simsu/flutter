import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/profile_upload.dart';

class AgeVerificationScreen extends StatelessWidget {
  const AgeVerificationScreen({super.key});

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
            const SizedBox(height: 40),
            // 1. 메인 질문 섹션
            const Text(
              '월리 서비스는 만 19세 이상 이용 가능해요!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.4),
                children: [
                  TextSpan(text: '현재 ', style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: '만 19세 이상인가요?',
                    style: TextStyle(color: Color(0xFF6DBB90)),
                  ),
                  TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // 2. 안내 문구
            const Text(
              '원활한 서비스 이용을 위한 질문으로,\n회원가입 시 사용자 정보 수집 목적 이외 사용되지 않습니다.',
              style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
            ),
            
            const Spacer(), // 버튼을 중앙보다 약간 아래로 배치하기 위해 조정 가능

            // 3. 메인 확인 버튼
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileUploadScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6DBB90),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35), // 완전한 라운드 형태
                    ),
                  ),
                  child: const Text(
                    '네, 만 19세 이상입니다.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            
            const Spacer(),

            // 4. 하단 미충족 링크
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 2),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.red, width: 1.0),
                    ),
                  ),
                  // 클릭 시 동작은 처음 페이지로 돌아간다.
                  child: const Text(
                    '만 19세 이상이 아니신가요?',
                    style: TextStyle(color: Colors.red, fontSize: 15),
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
