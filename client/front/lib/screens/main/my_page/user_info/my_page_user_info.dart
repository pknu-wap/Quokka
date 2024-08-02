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
  String _profileImagePath = 'assets/images/Avatar.svg'; // Default image path

  void _updateProfileImage(String newImagePath) {
    setState(() {
      _profileImagePath = newImagePath;
    });
  }

  void _resetProfileImage() {
    setState(() {
      _profileImagePath = 'assets/images/Avatar.svg'; // Reset to default image
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
                    onImageSaved: (newImagePath) {
                      _updateProfileImage(newImagePath);
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
