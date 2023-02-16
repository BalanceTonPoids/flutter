class ScaleData {
  final String id;
  final DateTime date;
  final int weight;
  final int fat;
  final int muscle;
  final int water;
  final int imc;

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
      weight: json['weight'] as int,
      fat: json['fat'] as int,
      muscle: json['muscle'] as int,
      water: json['water'] as int,
      imc: json['imc'] as int,
    );
  }
}
