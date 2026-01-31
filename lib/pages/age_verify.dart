import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/show_alert.dart';
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
                child: GestureDetector(
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    // 다이얼로그가 context를 바꿔서 아래에서 변경된 값을 사용해야한다.
                    // !플러터는 await 뒤의 context 사용을 지양하고 쓰려면 mounted 체크를 해야한다.
                    // stateFulWidget에서는 가능하지만 stateless에서는 불가능하다.
                    // showAlert를 stateful로 바꾸는 단점
                    // 1. alert 하나 띄우려고 위젯 생명주기 생성
                    // 2. 유틸 함수가 “위젯”으로 변질됨
                    // 3. 재사용성·가독성 나빠짐
                    // 4. 테스트/유지보수 부담 증가
                    // -> Stateless + context 캡처 방식 사용
                    await showAlert(
                        context, // <- async gap, 이 위젯이 dispose 된다면 런타임 에러가 발생할 수 있다.
                        title: '만 19세 미만 이용 불가',
                        message: '만 19세 미만은 월리 서비스를 이용할 수 없습니다.');
                    // 처음 페이지로 이동
                    navigator.popUntil((route) => route.isFirst);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.red, width: 1.0),
                      ),
                    ),
                    child: const Text(
                      '만 19세 이상이 아니신가요?',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
