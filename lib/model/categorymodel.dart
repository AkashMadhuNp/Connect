
import 'package:hive/hive.dart';
part 'categorymodel.g.dart';

@HiveType(typeId: 2)
class CategoryModel extends HiveObject{
  @HiveField(0)
  final String categoryTitle;

  @HiveField(1)
  final String? categoryIcon;
  
  @HiveField(2)
  final bool? done;

  @HiveField(3)
  final String userkey;


  CategoryModel({
    required this.categoryTitle, 
    required this.categoryIcon, 
    required this.done, 
    required this.userkey, 

  });
}