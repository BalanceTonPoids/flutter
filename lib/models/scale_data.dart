import 'dart:convert';

class ScaleData {
  final String id;
  final String date;
  final double weight;
  final double fat;
  final double muscle;
  final double water;
  final double imc;

  const ScaleData(
      {required this.id,
      required this.date,
      required this.weight,
      required this.fat,
      required this.muscle,
      required this.water,
      required this.imc});

  factory ScaleData.fromJson(Map<String, dynamic> json) {
    return ScaleData(
      id: json['_id'] as String,
      date: json['date'] as String,
      weight: json['weight'].toDouble(),
      fat: json['fat'].toDouble(),
      muscle: json['muscle'].toDouble(),
      water: json['water'].toDouble(),
      imc: json['IMC'].toDouble(),
    );
  }

  static Map<String, dynamic> toMap(ScaleData scale) => {
        'id': scale.id,
        'date': scale.date,
        'weight': scale.weight,
        'fat': scale.fat,
        'muscle': scale.muscle,
        'water': scale.water,
        'imc': scale.imc,
      };

  static List<String> encode(List<ScaleData> scales) =>
      scales
          .map<Map<String, dynamic>>((scale) => ScaleData.toMap(scale))
          .toList()
          .cast<String>() ??
      [];

  static List<ScaleData> decode(String scales) =>
      (json.decode(scales) as List<dynamic>)
          .map<ScaleData>((item) => ScaleData.fromJson(item))
          .toList();

  @override
  String toString() {
    return '{id: $id, date: $date, weight: $weight, fat: $fat, muscle: $muscle, water: $water, imc: $imc}';
  }
}
