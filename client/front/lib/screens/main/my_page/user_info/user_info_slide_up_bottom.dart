import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/screens/main/my_page/widgets/my_page_text.dart';
import 'widgets/slide_up_bottom_white_container.dart';

class SlideUpBottom extends StatelessWidget {
  final String nickName;
  final String initialImagePath;
  final Function(String) onImageSaved;
  final VoidCallback onReset;

  SlideUpBottom({
    required this.nickName,
    required this.initialImagePath,
    required this.onImageSaved,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    // 회색 슬라이드
    return Container(
      height: 500.h,
      decoration: BoxDecoration(
        color: Color(0xffF2F2F2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 13.47.h,
            // 흰색 컨테이너
            child: Container(
              width: 104.51.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Color(0xffAEAEAE),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: 49.38.h,
            left: 20.w,
            child: title('$nickName님,'),
          ),
          Positioned(
            top: 66.38.h,
            left: 20.w,
            child: title('프로필 이미지를 바꿔보세요'),
          ),
          Positioned(
            top: 112.h,
            left: 0.w,
            right: 0.w,
            child: SlideUpBottomWhiteContainer( // 흰색 컨테이너 내용
              initialImagePath: initialImagePath,
              onImageSaved: onImageSaved,
              onReset: onReset,
            ),
          ),
        ],
      ),
    );
  }
}