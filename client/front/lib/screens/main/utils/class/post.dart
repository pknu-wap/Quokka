import 'package:front/screens/main/utils/class/order.dart';

class Post{//게시글에 담긴 정보들
  Order o1;
  int errandNo; //게시글 번호
  String createdDate; //생성된 날짜
  double? distance; //도착지 거리
  String title; //게시글 제목
  String destination; //위치
  int reward; //보수
  String status; //상태 (모집중 or 진행중 or 완료됨)
  Post(this.o1, this.errandNo, this.createdDate, this.distance,
      this.title, this.destination, this.reward, this.status);
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      Order.fromJson(json['order']),
      json['errandNo'],
      json['createdDate'],
      json['distance'],
      json['title'],
      json['destination'],
      json['reward'],
      json['status'],
    );
  }
}