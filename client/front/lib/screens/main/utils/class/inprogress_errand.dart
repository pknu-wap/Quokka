class InProgressErrand{//진행중인 심부름이 간략하게 담고 있는 정보들
  int errandNo; //게시글 번호
  String title; //게시글 제목
  String due; //기간
  bool isUserOrder; //내가 요청자인지 심부름꾼인지 여부
  InProgressErrand(this.errandNo, this.title,
      this.due, this.isUserOrder);
  factory InProgressErrand.fromJson(Map<String, dynamic> json) {
    return InProgressErrand(
      json['errandNo'],
      json['title'],
      json['due'],
      json['isUserOrder'],
    );
  }
}