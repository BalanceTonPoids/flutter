class ScaleData {
  final String id;
  final DateTime date;
  final num weight;
  final num fat;
  final num muscle;
  final num water;
  final num imc;

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
      date: json['date'] as DateTime,
      weight: json['weight'] as num,
      fat: json['fat'] as num,
      muscle: json['muscle'] as num,
      water: json['water'] as num,
      imc: json['imc'] as num,
    );
  }
}
