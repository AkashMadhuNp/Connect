import 'package:first_project_app/db_Functions/category_db.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/screens/calenderScreen/calender_screen.dart';
import 'package:first_project_app/screens/home/view_category.dart';
import 'package:first_project_app/screens/task/task_done.dart';
import 'package:first_project_app/screens/task/task_notdone.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';

ValueNotifier<List<TaskModel>> taskNotifier = ValueNotifier([]);
ValueNotifier<List<TaskModel>> currentUserTaskNotifier = ValueNotifier([]);
ValueNotifier<List<TaskModel>> taskImportantNotifier = ValueNotifier([]);

class TaskFunctions extends ChangeNotifier {
  Future<void> addTask(TaskModel task) async {
    try {
      print("Debug: Starting addTask method");
      final box = await Hive.openBox<TaskModel>('task_db');
      print("Debug: Task box opened. Box length before adding: ${box.length}");
      
      await box.add(task);
      print("Debug: Task added to box. New box length: ${box.length}");
      
      await box.close();
      print("Debug: Task box closed after adding task");
    } catch (e) {
      print("Debug: Error in addTask method: $e");
      print("Debug: Error stack trace: ${StackTrace.current}");
      throw e;
    }
  }

  Future getAllTAsk() async {
    final userVariable = await Hive.openBox<TaskModel>('task_db');
    taskNotifier.value.clear();
    taskNotifier.value.addAll(userVariable.values);
    taskNotifier.notifyListeners();
  }

  Future<void> delete(int key) async {
    final box = await Hive.openBox<TaskModel>('task_db');
    await box.delete(key);
    await getAllTAsk();
    await box.close();

    currentUserTaskOnSelecteDdayNotifier.value.clear();
    currentUserTaskOnSelecteDdayNotifier.notifyListeners();
    filteredCategoryNotifier.value.clear();
    filteredCategoryNotifier.notifyListeners();
    filterTaskByCategoryOnThisDayNotifier.value.clear();
    filterTaskByCategoryOnThisDayNotifier.notifyListeners();
    await getCurrentUsertaskOnSelectedDay(today);
  }

  Future editTask(TaskModel value, int key) async {
    final taskVariable = await Hive.openBox<TaskModel>('task_db');
    await taskVariable.put(key, value);
    taskNotifier.value.clear();

    currentUserTaskOnSelecteDdayNotifier.notifyListeners();
    filterTaskByCategoryOnThisDayNotifier.value.clear();
    filterTaskByCategoryOnThisDayNotifier.notifyListeners();
    await CategoryFunction().filterTaskByCategoryOnThisDay(today);
    await getCurrentUsertaskOnSelectedDay(today);
    await CategoryFunction().filterTaskByCategoryOnThisDay(today);
  }

  Future markCompleted(TaskModel value, int key) async {
    final taskVariable = await Hive.openBox<TaskModel>('task_db');
    await taskVariable.put(key, value);
  }

  Future<List<TaskModel>> getCurrentUserTask(String userKeyy) async {
    final Box<TaskModel> taskBox = await Hive.openBox<TaskModel>('task_db');
    List<TaskModel> allTasks = taskBox.values.toList();
    List<TaskModel> currentUserTasks = allTasks.where((tasks) => tasks.userKey == userKeyy).toList();
    currentUserTaskNotifier.value.clear();
    currentUserTaskNotifier.value = currentUserTasks;
    currentUserTaskNotifier.notifyListeners();
    return currentUserTasks;
  }

  Future getCurrentUsertaskOnSelectedDay(DateTime selecteddate) async {
    String? key = await UserFunctions().getCurrentUserKey();
    await getCurrentUserTask(key!);
    List<TaskModel> allTaskOfCurrentUser = currentUserTaskNotifier.value.toList();
    List<TaskModel> currentUserTaskOnselectedDay = allTaskOfCurrentUser
        .where((task) => isSameDay(DateTime.parse(task.date!), selecteddate))
        .toList();
    currentUserTaskOnSelecteDdayNotifier.value = currentUserTaskOnselectedDay;
    currentUserTaskOnSelecteDdayNotifier.notifyListeners();
  }

  Future<List<TaskModel>> getTaskDone() async {
    List<TaskModel> currentUserAllTask = currentUserTaskNotifier.value;
    List<TaskModel> doneTask = currentUserAllTask.where((task) => task.iscompleted!).toList();
    taskDoneNotifier.value = doneTask;
    return doneTask;
  }

  Future<List<TaskModel>> getTaskImportant() async {
    List<TaskModel> currentUserAllTask = currentUserTaskNotifier.value;
    List<TaskModel> importantTask = currentUserAllTask.where((task) => task.isImportant!).toList();
    taskImportantNotifier.value = importantTask;
    return importantTask;
  }

  Future<List<TaskModel>> getTaskNotDone() async {
    List<TaskModel> currentUserAllTask = currentUserTaskNotifier.value;
    List<TaskModel> notDoneTask = currentUserAllTask.where((task) => !task.iscompleted!).toList();
    taskNotDoneNotifier.value = notDoneTask;
    return notDoneTask;
  }


  Future<void> toggleTaskImportance(TaskModel task)async{
    final taskVariable = await Hive.openBox<TaskModel>('task_db');
    task.isImportant = !task.isImportant!;
    await taskVariable.put(task.key, task);
    await getTaskImportant();
    notifyListeners();
  }
}