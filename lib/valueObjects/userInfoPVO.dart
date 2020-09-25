class UserInfoPVO {
  final String id;

  UserInfoPVO({this.id});

  factory UserInfoPVO.fromJSON(Map<String, dynamic> json) {
    return UserInfoPVO(
      id: json['id'],
    );
  }
}