class Error {
  String code;
  var httpStatus;
  String message;

  Error(this.code, this.httpStatus, this.message);

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      json['code'],
      json['httpStatus'],
      json['message'],
    );
  }
}
class order {
  int orderNo;
  String nickname; // 닉네임
  double score; // 평점
  order(this.orderNo, this.nickname, this.score);

  factory order.fromJson(Map<String, dynamic> json) {
    return order(
      json['orderNo'],
      json['nickname'],
      json['score'],
    );
  }
}
class HistoryData {
  // 게시글에 담긴 정보들
  order o1;
  int errandNo; //게시글 번호
  String createdDate; //생성된 날짜
  String title; //게시글 제목
  String destination; //위치
  int reward; // 심부름 값
  String status; //상태 (모집중 or 진행중 or 완료됨)
  HistoryData(
      this.o1,
      this.errandNo,
      this.createdDate,
      this.title,
      this.destination,
      this.reward,
      this.status,
);
  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      order.fromJson(json['order']),
      json['errandNo'],
      json['createdDate'],
      json['title'],
      json['destination'],
      json['reward'],
      json['status'],
    );
  }
}
