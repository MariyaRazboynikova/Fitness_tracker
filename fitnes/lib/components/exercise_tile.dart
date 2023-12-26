import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName; //тренировка будет иметь имя
  final String weight; //вес
  final String reps; //количество повторений
  final String sets; //количество подходов
  final bool isCompleted; //сделано или нет?
  void Function(bool?)? onCheckBoxChanged;

  ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Row(
          children: [
            Chip(
              label: Text(
                "${weight}kg",
              ),
            ),
            Chip(
              label: Text(
                "${reps}reps",
              ),
            ),
            Chip(
              label: Text(
                "${sets}sets",
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: (value) => onCheckBoxChanged!(value),
        ),
      ),
    );
  }
}
