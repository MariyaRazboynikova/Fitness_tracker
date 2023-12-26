//все данные, связанные с тренировками
import 'package:fitnes/models/exercise.dart';
import 'package:flutter/material.dart';

import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
/*

Структура данных тренировок

-Общий список, содержащий различные тренировки
-Каждая тренировка имеет имя и лист с упражнениями

*/
  List<Workout> wurkoutList = [
    //дефолтная тренировка
    Workout(name: "Все тело", exercises: [
      Exercise(
        name: "Приседания",
        weight: "10",
        reps: "10",
        sets: "3",
        isCompleted: false,
      ),
    ]),
    Workout(name: "Руки", exercises: [
      Exercise(
        name: "Отжимания",
        weight: "10",
        reps: "10",
        sets: "3",
        isCompleted: false,
      ),
    ])
  ];

  //метод для получения списка тренировок
  List<Workout> getWorkoutList() {
    return wurkoutList; //возвращаем дефолтный список
  }

  //получение продолжительности тренирвок
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    //возвращаем количество упражнений в этой тренировке
    return relevantWorkout.exercises.length;
  }

  //метод для добавления тренировок
  void addWorkout(String name) {
    //добавление новой тренировки с бланком списка упражнений
    wurkoutList.add(
      Workout(
        name: name,
        exercises: [],
      ),
    );
    notifyListeners();
  }

  //метод для добавления упражнений в тренировку
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    //поиск соответстующей тренировки
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
      Exercise(
        name: exerciseName,
        weight: weight,
        reps: reps,
        sets: sets,
        isCompleted: false,
      ),
    );
    notifyListeners();
  }

  //отметка о завершении тренировки
  void chekOffExercise(String workoutName, String exerciseName) {
    //поиск соответстующей тренировки
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    //чек логического значения, показывающий, выполнил ли пользователь упражнение
    relevantExercise.isCompleted == !relevantExercise.isCompleted;
    notifyListeners();
  }

  //возращение соответствующего объекта тренировки с учетом названия тренировки
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout = wurkoutList.firstWhere((workout) =>
        workout.name ==
        workoutName); //находим, когда имя тренировки совпадает с названием тренировки, которую мы хотим добавить к упражнению
    return relevantWorkout;
  }

  //возвращение подходящего объекта упражнений с учетом иени тренировки и имени упражнения
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    //поиск соответстующей тренировки
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    //потом находим подходящее упражнение в этой тренировке
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
}
