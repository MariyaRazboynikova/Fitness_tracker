import 'package:fitnes/data/workout_data.dart';
import 'package:fitnes/pages/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //текстовый контроллер
  final newWorkoutNameController = TextEditingController();

  //создание новой тренировки
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Создайте новую тренировк'),
        content: TextField(
          //используя контрлолер, мы можем получить доступ к тому, что пользователь написал в текстовом поле
          controller: newWorkoutNameController,
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

  //переход на страницу с тренировкой
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: workoutName,
        ),
      ),
    );
  }

  //сохранить тренировку
  void save() {
    //получение имен тренировки из текстового контроллеера
    String newWorkoutName = newWorkoutNameController.text;
    //добавление тренировки в список базы данных тренировок
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
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
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Трекер тренировок'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: createNewWorkout,
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
              itemCount: value.getWorkoutList().length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(value.getWorkoutList()[index].name),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () => goToWorkoutPage(value
                          .getWorkoutList()[index]
                          .name), //переходим на страницу, где в апбере название тренировки
                    ),
                  ))),
    );
  }
}
