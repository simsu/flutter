import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/set_nickname.dart';

class ProfileUploadScreen extends StatelessWidget {
  const ProfileUploadScreen({super.key});

  bool get _isNextButtonEnabled => true; // 사진 업로드 여부에 따라 변경 필요
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
      body: SingleChildScrollView( // 내용이 길어질 수 있으므로 스크롤 가능하게 설정
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // 1. 헤더 텍스트
              const Text(
                '회원님의 얼굴이 잘 보이는 프로필 사진을 업로드해 주세요!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.4),
              ),
              const SizedBox(height: 12),
              const Text(
                '반려동물과 함께 찍은 사진도 괜찮아요.',
                style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
              ),
              const Text(
                '단, 반려동물만 나온 사진은 사용할 수 없어요.',
                style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
              ),
              const SizedBox(height: 40),

              // 2. 중앙 업로드 버튼
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 50, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),

              // 3. 프로필 사진 예시 섹션
              const Text(
                '프로필 사진 예시',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildExampleImage('O', Colors.blue),
                  _buildExampleImage('O', Colors.blue),
                  _buildExampleImage('X', Colors.red),
                ],
              ),
              const SizedBox(height: 20),

              // 4. 하단 안내 박스
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey[400], size: 24),
                    const SizedBox(width: 24),
                    const Expanded(
                      child: Text(
                        '해당 사진은 월리 서비스의 프로필 사진으로 사용되며, 돌봄 이용 시 신원을 확인하는 목적으로 회원님과 예약을 진행하는 돌보미인 월리에게만 공개됩니다.',
                        style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100), // 하단 버튼 공간 확보
            ],
          ),
        ),
      ),
      // 5. 고정 하단 버튼
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: ElevatedButton(
            onPressed: _isNextButtonEnabled
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const NicknameSetupScreen()),
                          );
                        }
                      : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6DBB90),
              disabledBackgroundColor: const Color(0xFFE0E0E0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('다음', style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
    );
  }

  // 예시 이미지 아이템 위젯
  Widget _buildExampleImage(String status, Color statusColor) {
    final randomId = DateTime.now().millisecondsSinceEpoch + status.hashCode;
    final imageUrl = 'https://picsum.photos/seed/$randomId/200';

    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: statusColor.withValues(alpha: 0.5), width: 3),
            image: DecorationImage(
            image: NetworkImage(imageUrl), // 인터넷에서 이미지 불러오기
            fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          status,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: statusColor),
        ),
      ],
    );
  }
}
