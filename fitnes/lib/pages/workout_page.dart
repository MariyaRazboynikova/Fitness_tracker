import 'package:fitnes/components/exercise_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/workout_data.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({
    super.key,
    required this.workoutName,
  });

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  //нажатие чекбокса
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false).chekOffExercise(
      workoutName,
      exerciseName,
    );
  }

  //text controllers
  final exerciseNameCotroller = TextEditingController();
  final weightCotroller = TextEditingController();
  final repsCotroller = TextEditingController();
  final setsCotroller = TextEditingController();

  //создание нвого упражнения
  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Добавьте новое упражнение'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //exercise name
            TextField(
              controller: exerciseNameCotroller,
            ),

            //weight
            TextField(
              controller: weightCotroller,
            ),

            //reps
            TextField(
              controller: repsCotroller,
            ),

            //sets
            TextField(
              controller: setsCotroller,
            ),
          ],
        ),
        actions: [
          //кнопка сохранения
          MaterialButton(
            onPressed: save,
            child: Text('Сохранить'),
          ),
          //кнопка закрытия
          MaterialButton(
            onPressed: cancel,
            child: Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  //сохранить тренировку
  void save() {
    //получение имен упражнений из текстового контроллеера
    String newExerciseName = exerciseNameCotroller.text;
    String weight = weightCotroller.text;
    String reps = repsCotroller.text;
    String sets = setsCotroller.text;
    //добавление упражднений в список базы данных тренировок
    Provider.of<WorkoutData>(context, listen: false).addExercise(
      widget.workoutName,
      newExerciseName,
      weight,
      reps,
      sets,
    );
    //закрытие диалогового окна
    Navigator.pop(context);
    clear();
  }

  //закрыть окно
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  //очистка контроллера
  void clear() {
    exerciseNameCotroller.clear();
    weightCotroller.clear();
    repsCotroller.clear();
    setsCotroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.workoutName),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise, //для функции void не нужны ()=>
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
            itemBuilder: (context, index) => ExerciseTile(
                  exerciseName: value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .name,
                  weight: value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .weight,
                  reps: value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .reps,
                  sets: value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .sets,
                  isCompleted: value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .isCompleted,
                  onCheckBoxChanged: (val) => onCheckBoxChanged(
                    widget.workoutName,
                    value
                        .getRelevantWorkout(widget.workoutName)
                        .exercises[index]
                        .name,
                  ),
                )),
      ),
    );
  }
}
