class Exercise {
  final String name; //тренировка будет иметь имя
  final String weight; //вес
  final String reps; //количество повторений
  final String sets; //количество подходов
  bool isCompleted; //сделано или нет?

  Exercise({
    required this.name,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
  });

  get exercises => null;
}
