class Order{
  int orderNo;
  String nickname; //닉네임
  double score; //평점
  Order(this.orderNo, this.nickname, this.score);
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      json['orderNo'],
      json['nickname'],
      json['score'],
    );
  }
}
