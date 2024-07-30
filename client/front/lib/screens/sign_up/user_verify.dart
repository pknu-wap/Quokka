import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/screens/sign_up/widgets/text/sign_up_text.dart';
import 'package:front/services/sign_up/extract_text_from_img.dart';
import 'user_check.dart';

class UploadImage extends StatefulWidget {
  final String requestMail;
  const UploadImage( {super.key, required this.requestMail});

  @override
  UploadImageState createState() => UploadImageState();
}
class UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.only(top: 26.0.h),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 26.0.h),
            child: SizedBox(
              height: 25.0,
              child: Text(
                '본인인증',
                style: TextStyle(
                  fontFamily: 'paybooc',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.01,
                  color: const Color(0xff111111),
                ),
              ),
            ),
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 22.0.w, top: 30.0.h),
                child: title('모바일 학생증 인증'),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 10.0.h),
                child: Stack(
                  children: <Widget>[
                    SvgPicture.asset('assets/images/upload_image_box.svg', width: 320.w, height: 202.h, fit: BoxFit.cover),
                    Positioned(
                      left: 0.w, right: 0.w, top: 0.h, bottom: 0.h,
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/upload_image_button.svg',
                          width: 80.w,
                          height: 80.h,
                          // color: Color(0xff8D8D8D),
                        ),
                        onPressed: () {
                          // 이 버튼을 누르면 갤러리가 열리고 이미지를 가져오도록 설정
                          parseTheText(widget.requestMail).then((_) {
                            u1.mail = widget.requestMail;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Check_Image(u1: u1)
                              ),);
                            initState();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 22.0.w, top: 36.0.h),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 9.0.w),
                            child: title('업로드 파일 예시'),
                          ),
                          Text(
                            '파일 형식  jpg / png',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              letterSpacing: 0.01,
                              color: const Color(0xff373737),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 139.58.w,
                      height: 256.44.h,
                      margin: EdgeInsets.only(left: 22.0.w, top: 17.0.h),
                      child: SvgPicture.asset('assets/images/upload_image_sample.svg'),
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}