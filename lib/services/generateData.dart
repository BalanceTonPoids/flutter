import 'dart:math';

class GenerateData {
  static Map<String, double> generate({double weight = 70.0}) {
    final Map<String, double> result = {};
    final double minWeight = weight - 5;
    final double maxWeight = weight + 5;
    final double imc = weight / pow(1.8, 2);
    final double minImc = imc - 2;
    final double maxImc = imc + 2;
    const double minFat = 10;
    final double maxFat = min(40, (maxImc - 15) / 2);
    const double minWater = 40;
    const double maxWater = 80;
    const double minMuscle = 20;
    const double maxMuscle = 70;

    // Generate random values for weight, fat, water, imc and muscle
    final Random random = Random();
    final double randomWeight =
        minWeight + random.nextDouble() * (maxWeight - minWeight);
    final double randomFat = minFat + random.nextDouble() * (maxFat - minFat);
    final double randomWater =
        minWater + random.nextDouble() * (maxWater - minWater);
    final double randomImc = minImc + random.nextDouble() * (maxImc - minImc);
    final double randomMuscle =
        minMuscle + random.nextDouble() * (maxMuscle - minMuscle);

    result['weight'] = double.parse(randomWeight.toStringAsFixed(2));
    result['fat'] = double.parse(randomFat.toStringAsFixed(2));
    result['water'] = double.parse(randomWater.toStringAsFixed(2));
    result['imc'] = double.parse(randomImc.toStringAsFixed(2));
    result['muscle'] = double.parse(randomMuscle.toStringAsFixed(2));

    return result;
  }
}
