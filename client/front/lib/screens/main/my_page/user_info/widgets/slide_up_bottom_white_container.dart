import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'white_container/white_container_row_button_list.dart';
import 'white_container/white_container_user_image.dart';
import 'white_container/white_container_user_image_row_list.dart';

class SlideUpBottomWhiteContainer extends StatefulWidget {
  final String initialImagePath;
  final Function(String) onImageSaved;
  final VoidCallback onReset;

  SlideUpBottomWhiteContainer({
    required this.initialImagePath,
    required this.onImageSaved,
    required this.onReset,
  });

  @override
  _SlideUpBottomWhiteContainerState createState() => _SlideUpBottomWhiteContainerState();
}

class _SlideUpBottomWhiteContainerState extends State<SlideUpBottomWhiteContainer> {
  late String _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImagePath;
  }

  @override
  Widget build(BuildContext context) {
    // 프로필 이미지 선택 흰색 컨테이너
    return Container(
      height: 390.h,
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          // 흰색 컨테이너 안 프로필 이미지 미리 보기
          WhiteContainerUserImage(selectedImagePath: _selectedImage),

          // 이미지 선택 가로 슬라이드 및 페이지 번호 현황 나타냄
          Expanded(
            child: WhiteContainerUserImageRowList(
              onImageSelected: (newImagePath) {
                setState(() {
                  _selectedImage = newImagePath;
                });
              },
            ),
          ),

          // 지우기 및 저장 버튼
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: WhiteContainerRowButtonList(
              onSave: () {
                widget.onImageSaved(_selectedImage);
                Navigator.pop(context);
              },
              onReset: () {
                widget.onReset();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

