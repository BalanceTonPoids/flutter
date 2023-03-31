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
  final String createdAt;
  final String updatedAt;
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
      required this.createdAt,
      required this.updatedAt,
      required this.scaleData});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        email: json['email'],
        name: json['name'] ?? '',
        phone: json['phone'] ?? '',
        gender: json['gender'] ?? 'M',
        metric: json['metric'] ?? '',
        age: json['age'] ?? 0,
        height: json['height'] ?? 0,
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        scaleData: json['scale_data'] != null
            ? (json['scale_data'] as List)
                .map((e) => ScaleData.fromJson(e))
                .toList()
            : []);
  }

  ScaleData? getLastScale() {
    if (scaleData.isNotEmpty) {
      scaleData.sort((a, b) => b.date.compareTo(a.date));
      return scaleData.last;
    }
    return null;
  }
}
