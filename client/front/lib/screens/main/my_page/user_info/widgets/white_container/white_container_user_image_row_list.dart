import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/screens/main/my_page/user_info/widgets/camera/camera.view.dart';
import 'package:image_picker/image_picker.dart';

class WhiteContainerUserImageRowList extends StatefulWidget {
  final Function(String, bool) onImageSelected;

  WhiteContainerUserImageRowList({required this.onImageSelected});

  @override
  _WhiteContainerUserImageRowListState createState() => _WhiteContainerUserImageRowListState();
}

class _WhiteContainerUserImageRowListState extends State<WhiteContainerUserImageRowList> {
  // 이미지 선택 가로 슬라이드 이미지 목록
  final List<String> userImagePaths = [
    'assets/images/userImageCamera.svg',
    'assets/images/userImage1.svg',
    'assets/images/userImage2.svg',
    'assets/images/userImage3.svg',
    'assets/images/userImageGallery.svg',
    'assets/images/userImage4.svg',
    'assets/images/userImage5.svg',
    'assets/images/userImage6.svg',
    'assets/images/userImage7.svg',
    'assets/images/userImage8.svg',
    'assets/images/userImage9.svg',
    'assets/images/userImage10.svg',
    'assets/images/userImage11.svg',
    'assets/images/userImage12.svg',
    'assets/images/userImage13.svg',
    'assets/images/userImage14.svg',
    'assets/images/userImage1.svg',
    'assets/images/userImage2.svg',
    'assets/images/userImage3.svg',
    'assets/images/userImage4.svg',
    'assets/images/userImage5.svg',
    'assets/images/userImage6.svg',
    'assets/images/userImage7.svg',
    'assets/images/userImage8.svg',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0; // 현재 이미지 페이지

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final next = _pageController.page?.round() ?? 0;
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _selectImage(int imageIndex) async {
    if (imageIndex == 0) { // 카메라 이미지
      // 카메라 선택
      final imagePath = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => CameraView(imageSource: ImageSource.camera),
        ),
      );
      if (imagePath != null && imagePath.isNotEmpty) {
        widget.onImageSelected(imagePath, false); // 카메라 이미지 출력
      }
    } else if (imageIndex == 4) { // 갤러리 이미지
      // 갤러리 선택
      final imagePath = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => CameraView(imageSource: ImageSource.gallery),
        ),
      );
      if (imagePath != null && imagePath.isNotEmpty) {
        widget.onImageSelected(imagePath, false); // 갤러리 이미지 출력
      }
    } else { // 0, 4 제외한 나머지 이미지
      widget.onImageSelected(userImagePaths[imageIndex], true); // 캐릭터 이미지 출력
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageCount = (userImagePaths.length / 8).ceil(); // 한 페이지 당 이미지 개수

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pageCount,
              itemBuilder: (context, pageIndex) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // 가로 이미지 개수
                    crossAxisSpacing: 28.w, // 가로 이미지 간격
                    mainAxisSpacing: 13.h, // 세로 이미지 간격
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 33.w,
                    right: 33.w,
                    top: 22.h,
                    bottom: 94.53.h,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    final imageIndex = pageIndex * 8 + index;
                    if (imageIndex < userImagePaths.length) {
                      return GestureDetector(
                        onTap: () async {
                          await _selectImage(imageIndex);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200.0),
                          ),
                          child: Center(
                            child: SvgPicture.asset( // 가로 슬라이드에 이미지 출력
                              userImagePaths[imageIndex],
                              width: 50.sp,
                              height: 50.sp,
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox();
                  },
                );
              },
            ),
          ),

          // 이미지 슬라이드 페이지 위치 및 페이지 수 확인
          Padding(
            padding: EdgeInsets.only(bottom: 0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pageCount,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Color(0xff7C3D1A)
                        : Color(0xffD9D9D9),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}