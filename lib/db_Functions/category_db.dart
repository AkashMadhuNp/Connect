import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/categorymodel.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/screens/home/view_category.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';

ValueNotifier<List<CategoryModel>> categoryNotifier = ValueNotifier([]);
ValueNotifier<List<CategoryModel>> currentUserCategoryNotifier = ValueNotifier([]);
ValueNotifier<List<TaskModel>> filterTaskByCategoryOnThisDayNotifier = ValueNotifier([]);

class CategoryFunction extends ChangeNotifier {
  Future addCategory(CategoryModel value)async{
    final Box<CategoryModel> box = await Hive.openBox<CategoryModel>('category_db');
    await box.add(value);
    await getCategory();
    await box.close();
    
  }


  Future getCategory()async{
    final Box<CategoryModel> box = await Hive.openBox<CategoryModel>('category_db');
    categoryNotifier.value.clear();
    categoryNotifier.value.addAll(box.values);
    categoryNotifier.notifyListeners();
  }


  

  Future deleteCategory(int key) async{
    final Box<CategoryModel> box = await Hive.openBox<CategoryModel>('category_db');
    box.delete(key);
    await box.close();
    await getCategory();
  }

  Future currentUserCategory(String userKeyy)async{
    final Box<CategoryModel> category = await Hive.openBox<CategoryModel>('category_db');
    List<CategoryModel> allcategories = category.values.toList();
    List<CategoryModel> currentUserCategory = 
    allcategories.where((element)=>element.userkey == userKeyy).toList();
    currentUserCategoryNotifier.value = currentUserCategory;
    currentUserCategoryNotifier.notifyListeners();
    return currentUserCategory;
  }


  Future filterTaskByCategory(String category)async{
    await TaskFunctions().getCurrentUserTask(userKey!);
    List<TaskModel> currentUserAllTask = currentUserTaskNotifier.value;
    List<TaskModel> matchingTasks = currentUserAllTask.where((task){
      return task.taskType == category;
    }).toList();
    filteredCategoryNotifier.value.clear();
    filteredCategoryNotifier.value = matchingTasks;
    filteredCategoryNotifier.notifyListeners();
    return matchingTasks;

  }


  Future filterTaskByCategoryOnThisDay(DateTime selectedDatee) async {
    List<TaskModel> filteredTaskByCategory = filteredCategoryNotifier.value;
    List<TaskModel> filterTaskByCategoryOnThisDay = filteredTaskByCategory
        .where((task) => isSameDay(DateTime.parse(task.date!), selectedDatee))
        .toList();
    filterTaskByCategoryOnThisDayNotifier.value = filterTaskByCategoryOnThisDay;
    filterTaskByCategoryOnThisDayNotifier.notifyListeners();
  }

  Future taskDoneinCategory(String category)async{
    List<TaskModel> task = await filterTaskByCategory(category);
    List<TaskModel> filteredTasks = task.where((element)=>element.iscompleted == true).toList();
    return filteredTasks.length;
   }


   Future taskNotDoneinCategory(String category)async{
    List<TaskModel> task = await filterTaskByCategory(category);
    List<TaskModel> filteredTasks = task.where((element)=> element.iscompleted == false).toList();
    return filteredTasks.length;
   }

  Future<bool> checkCategoryExists(String categoryTitle)async{
    List<CategoryModel> userCategories = await currentUserCategory(userKey!);
    String lowercasescategories = categoryTitle.toLowerCase();

    return userCategories.any((category)=>category.categoryTitle.toLowerCase()==lowercasescategories);
  }




  

}