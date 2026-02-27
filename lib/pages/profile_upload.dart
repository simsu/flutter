import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_2/pages/set_nickname.dart';

class ProfileUploadScreen extends StatefulWidget {
  const ProfileUploadScreen({super.key});

  @override
  State<ProfileUploadScreen> createState() => _ProfileUploadScreenState();
}

class _ProfileUploadScreenState extends State<ProfileUploadScreen> {
  Uint8List? _editedImage;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _circleKey = GlobalKey(); // 원형 위치 파악용
  bool get _isNextButtonEnabled => _editedImage != null;
  bool _isMenuOpen = false; // 팝업 메뉴 열림 상태 플래그

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );
      if (pickedFile == null) return;
      // 1. XFile -> Uint8List 변환
      final Uint8List imageBytes = await pickedFile.readAsBytes();
      if (!mounted) return; // 위젯이 여전히 트리에 있는지 확인
      // 2. image_editor_plus로 편집
      final editedImage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageEditor(
            image: imageBytes,
          ),
        ),
      );
      // 3. 결과 저장
      if (editedImage != null) {
        setState(() {
          _editedImage = editedImage as Uint8List;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지를 불러오는데 실패했습니다: $e')),
        );
      }
    }
  }

  // 이미지와 동일한 팝업 메뉴를 띄우는 함수
  void _showImagePickerOptions(TapUpDetails details) {
    if (_isMenuOpen) return;
    _isMenuOpen = true;  // setState 없이 플래그만 변경

    final Offset touchOffset = details.globalPosition; // 터치 좌표

    // 이미지의 팝업 위치를 재현하기 위한 좌표 계산
    showMenu<void>(
      context: context,
      constraints: BoxConstraints(minWidth: 180.w),
      position: RelativeRect.fromLTRB(
        touchOffset.dx,  // 터치한 x
        touchOffset.dy,  // 터치한 y
        touchOffset.dx,
        0,
      ),
      items: [
        _buildPopupItem(
          title: '사진 가져오기',
          icon: Icons.photo_outlined,
          onTap: () => _pickImage(ImageSource.gallery),
        ),
        const PopupMenuDivider(height: 1),
        _buildPopupItem(
          title: '직접 촬영하기',
          icon: Icons.camera_alt_outlined,
          onTap: () => _pickImage(ImageSource.camera),
        ),
      ],
    ).whenComplete(() {
      _isMenuOpen = false;
    });
  }
  // 팝업 메뉴 항목 위젯 (텍스트 좌측, 아이콘 우측)
  PopupMenuItem<void> _buildPopupItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return PopupMenuItem<void>(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          Icon(icon, color: Colors.grey[400], size: 28),
        ],
      ),
    );
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
              child: GestureDetector(
                onTapUp: _showImagePickerOptions,
                child: Container(
                  key: _circleKey,
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                    image: _editedImage != null
                        ? DecorationImage(image: MemoryImage(_editedImage!), fit: BoxFit.cover)
                        : null,
                  ),
                  child: _editedImage == null
                      ? Icon(Icons.add, size: 50, color: Colors.grey[300])
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 50),

              // 3. 프로필 사진 예시 섹션
              const Text(
                '프로필 사진 예시',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildExampleImage('O', Colors.blue, 'https://picsum.photos/seed/1/200'),
                  _buildExampleImage('O', Colors.blue, 'https://picsum.photos/seed/2/200'),
                  _buildExampleImage('X', Colors.red, 'https://picsum.photos/seed/3/200'),
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
  Widget _buildExampleImage(String status, Color statusColor, String url) {

    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: statusColor.withValues(alpha: 0.5), width: 3),
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
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
// 프로필 버튼 누르면 누른 위치에서 팝업이 (갤러리 선택, 사진 촬영) 떠야한다.
// method channel 로 네이티브 기능 호출 필요
// icon: Image.asset('경로', width: 24, height: 24)
