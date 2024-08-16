import 'package:flutter/material.dart';
import 'package:front/widgets/bar/navigation_bar.dart'; //insert overlay 하는데 필요함
import '../../errand_list/errand_list.dart'; //overlay 없애는데 필요함
import 'user_info_column_list.dart';
import 'user_info_slide_up_bottom.dart';
import 'user_info_user_image.dart';
import 'widgets/my_page_app_bar.dart';

class MyPageUserInfo extends StatefulWidget {
  final String nickName;
  final String name;
  final String email;
  final String password;

  const MyPageUserInfo({
    Key? key,
    this.nickName = "수현수현이",
    this.name = "김수현",
    this.email = "202313114@pukyong.ac.kr",
    this.password = "sssssss",
  }) : super(key: key);

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
  void initState() {
    // 위젯의 초기 상태 설정 = 상태 변화 감지
    super.initState();
    //errand_list에서 생성한 overlay를 제거함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (overlayEntry != null) {
        overlayEntry!.remove();
        overlayEntry = null;
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) async {
      if (didPop) {
        insertOverlay(context); //뒤로가기 하면 overlay 생기게 다시 넣어줌
        return;
      }
      Navigator.of(context).pop();
    },
      child: Scaffold(
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
                    nickName: widget.nickName,
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
            ColumnList(nickName: widget.nickName, name: widget.name, email: widget.email, password: widget.password),
          ],
        ),
      ),
     )
    );
  }
}
