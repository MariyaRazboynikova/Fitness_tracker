import 'exercise.dart';

class Workout {
  final String name; //тренировка будет иметь имя
  final List<Exercise> exercises; //и список упражнений в этой тренировке

  Workout({
    required this.name,
    required this.exercises,
  });
}
