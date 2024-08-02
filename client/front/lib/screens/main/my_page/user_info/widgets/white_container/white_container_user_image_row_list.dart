import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhiteContainerUserImageRowList extends StatefulWidget {
  final Function(String) onImageSelected;

  WhiteContainerUserImageRowList({required this.onImageSelected});

  @override
  _WhiteContainerUserImageRowListState createState() =>
      _WhiteContainerUserImageRowListState();
}

class _WhiteContainerUserImageRowListState
    extends State<WhiteContainerUserImageRowList> {
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
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
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

  @override
  Widget build(BuildContext context) {
    int pageCount = (userImagePaths.length / 8).ceil();

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
                    crossAxisCount: 4,
                    crossAxisSpacing: 28.w,
                    mainAxisSpacing: 13.h,
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
                        onTap: () {
                          widget.onImageSelected(userImagePaths[imageIndex]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200.0),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
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
          // 페이지 수 및 현재 페이지 위치
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
