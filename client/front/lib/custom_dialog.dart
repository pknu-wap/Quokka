import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget{
  final String alertMessage;
  CustomDialog({required this.alertMessage});

  // sign_up.dart
  @override
  Widget build(BuildContext context) {
    return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              // padding: EdgeInsets.all(20),
              width: 323,
              height: 214,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16.04),
                    child: Image.asset(
                      'assets/images/alert.png',
                      width: 76.83,
                      height: 76.83,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4.08),
                    child: Text(
                      alertMessage,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 0.00,
                        color: Color(0xff1A1A1A),
                      ),
                      textAlign: TextAlign.center, // 텍스트 중앙 정렬
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 17.77),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(281.1, 47.25)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // 원하는 모양에 따라 BorderRadius 조절
                          ),
                        ),
                      ),
                      child: Text(
                        "확인",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.00,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  void signUpDialog(BuildContext context, String alertMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(alertMessage: alertMessage);
      },
    );
  }