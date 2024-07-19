class User {
  String mail; //이메일      *sign_up.dart에서 받음*
  String department; //전공  *이 페이지에서 임시로 받는 값* 본 데이터는 user_check.dart에서 받음
  String name; //이름        *이 페이지에서 임시로 받는 값*
  String id; //학번          *이 페이지에서 임시로 받는 값*
  String pw; //비밀번호       *user_info.dart에서 받는값*
  String nickname; //닉네임  *user_info.dart에서 받는값*

  User(this.mail, this.department, this.name,
      this.id, this.pw, this.nickname);

  Map<String, dynamic> toJson(){
    return {
      "mail" : mail,
      "department" : department,
      "name" : name,
      "id" : id,
      "pw" : pw,
      "nickname" : nickname,
    };
  }
}