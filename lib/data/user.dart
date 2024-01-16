// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  int id;
  String userName;
  int point;
  String createDate;

  User({
    required this.id,
    required this.userName,
    required this.point,
    required this.createDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'userName': String userName,
        'point': int point,
        'createDate': String createDate,
      } =>
        User(id: id, userName: userName, point: point, createDate: createDate),
      _ => throw const FormatException('Failed to load user'),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'point': point,
      'createDate': createDate,
    };
  }
}
