import 'package:flutter/cupertino.dart';

class TableScreen2 extends StatelessWidget {
  final int reward;
  final bool isCash;

  TableScreen2({
    required this.reward,
    required this.isCash,
  });

  String isCashType(bool isCash) {
    if (isCash == true){
      return "현금결제";
    }
    else{
      return "계좌이체";
    }
  }

  late final List<Map<String, dynamic>> list = [
    {
      'text': "장소",
      'content': "${reward} 원",
    },
    {
      'text': "요청 사항",
      'content': isCashType(isCash),
    }
  ];

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle1 = TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w300,
      fontSize: 11,
      letterSpacing: 0.001,
      color: Color(0xffFFFFFF),
    );
    final TextStyle textStyle2 = TextStyle(
      fontFamily: 'SANGJUDajungdagam',
      fontWeight: FontWeight.w300,
      fontSize: 12,
      letterSpacing: 0.00,
      color: Color(0xff111111),
    );

    // 금액 및 결제 표
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Table(
        columnWidths: { // 표의 각 너비 조정
          0: FixedColumnWidth(62),
          1: FixedColumnWidth(176),
        },
        border: TableBorder.all(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffF1F1F1),
          // top: BorderSide(color: Color(0xffF1F1F1), width: 2), // 위쪽 테두리 색상 및 너비 설정
          // bottom: BorderSide(color: Color(0xffF1F1F1), width: 2), // 아래쪽 테두리 색상 및 너비 설정
          // left: BorderSide(color: Color(0xffF1F1F1), width: 2), // 왼쪽 테두리 색상 및 너비 설정
          // right: BorderSide(color: Color(0xffF1F1F1), width: 2), // 오른쪽 테두리 색상 및 너비 설정
          // horizontalInside: BorderSide(color: Color(0xffF1F1F1), width: 1), // 안 쪽 가로 줄
        ),
        children: List.generate(2, (index) {
          return TableRow(children: [
            TableCell(
              child: Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                // ),
                  height: 30,
                  color: Color(0xff674333),
                  child: Center(child: Text(list[index]['text'], style: textStyle1,))), // 가운데 정렬
            ),
            TableCell(
              child: Container(
                  height: 30,
                  padding: EdgeInsets.all(9), // 왼쪽 정렬 띄우기 위함
                  color: Color(0xffFFFFFF),
                  child: Align(
                      alignment: Alignment.centerLeft, // 왼쪽 정렬
                      child: Text(list[index]['content'], style: textStyle2,))),
            ),
          ]);
        }),
      ),
    );
  }
}