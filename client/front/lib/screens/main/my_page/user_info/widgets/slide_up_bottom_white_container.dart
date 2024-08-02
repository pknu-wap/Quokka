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
          //사용자 이미지 선택 미리 보기
          WhiteContainerUserImage(selectedImage: _selectedImage),
          // Image selection grid
          Expanded(
            // 사용자 이미지 선택 가로 목록
            child: WhiteContainerUserImageRowList(
              onImageSelected: (newImagePath) {
                setState(() {
                  _selectedImage = newImagePath;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            // 지우기 버튼 및 저장 버튼
            child: WhiteContainerRowButtonList(
              onSave: () {
                widget.onImageSaved(_selectedImage); // 현재 선택한 이미지 함께 회원 정보 페이지로 넘기기
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
