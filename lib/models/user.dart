import 'package:balancetonpoids/models/scale_data.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String gender;
  final String metric;
  final int age;
  final int height;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ScaleData> scaleData;

  const User(
      {required this.id,
      required this.email,
      required this.name,
      required this.phone,
      required this.gender,
      required this.metric,
      required this.age,
      required this.height,
      required this.role,
      required this.createdAt,
      required this.updatedAt,
      required this.scaleData});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        email: json['email'],
        name: json['name'],
        phone: json['phone'],
        gender: json['gender'],
        metric: json['metric'],
        age: json['age'],
        height: json['height'],
        role: json['role'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        scaleData: json['scale_data']);
  }
}
