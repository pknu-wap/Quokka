import 'package:flutter/material.dart';
import 'user_info_column_list.dart';
import 'user_info_slide_up_bottom.dart';
import 'user_info_user_image.dart';
import 'widgets/my_page_app_bar.dart';

class MyPageUserInfo extends StatefulWidget {
  @override
  _MyPageUserInfoState createState() => _MyPageUserInfoState();
}

class _MyPageUserInfoState extends State<MyPageUserInfo> {
  String _profileImagePath = 'assets/images/Avatar.svg'; // 기본 프로필 이미지
  bool _isSvg = true; // svg 이미지

  void _updateProfileImage(String newImagePath, bool newIsSvg) {
    setState(() {
      _profileImagePath = newImagePath;
      _isSvg = newIsSvg;
    });
  }

  // 리셋 버튼 클릭 시
  void _resetProfileImage() {
    setState(() {
      _profileImagePath = 'assets/images/Avatar.svg'; // 기본 프로필 이미지
      _isSvg = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyPageAppBar(),
      body: Center(
        child: Column(
          children: [
            UserImage(
              imagePath: _profileImagePath, // Pass current profile image
              isSvg: _isSvg,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => SlideUpBottom(
                    nickName: "수현수현이",
                    initialImagePath: _profileImagePath,
                    initialIsSvg: _isSvg,
                    onImageSaved: (newImagePath, newIsSvg) {
                      _updateProfileImage(newImagePath, newIsSvg);
                    },
                    onReset: _resetProfileImage,
                  ),
                );

              },
            ),
            ColumnList(),
          ],
        ),
      ),
    );
  }
}
