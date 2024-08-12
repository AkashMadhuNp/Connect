
import 'package:first_project_app/model/categorymodel.dart';
import 'package:first_project_app/model/eventmodel.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:first_project_app/screens/homescreen.dart';
import 'package:first_project_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  print('Hive initialized');
  
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
    print('UserModelAdapter registered');
  }
  
  await Hive.openBox<UserModel>('user_db');
  print('User Box opened');

  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
    print("CategoryModel Registerd");
  }

  await Hive.openBox<CategoryModel>('category_db');
  print('Category Box Opened');


  if(!Hive.isAdapterRegistered(TaskModelAdapter().typeId)){
    Hive.registerAdapter(TaskModelAdapter());
    print("TaskModel Registered");
  }

  await Hive.openBox<TaskModel>('task_db');
  print("Task Box Opened");


  if(!Hive.isAdapterRegistered(EventModelAdapter().typeId)){
    Hive.registerAdapter(EventModelAdapter());
    print("EventModel Registered");
  }
  await Hive.openBox<EventModel>('event_db');
  print("Event Box opened");

  
  
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}