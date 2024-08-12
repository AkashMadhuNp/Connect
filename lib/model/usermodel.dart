import 'package:hive/hive.dart';
part 'usermodel.g.dart';


@HiveType(typeId: 0)
class UserModel extends HiveObject{
  
  @HiveField(0)
   String ? name;

  @HiveField(1)
  String ? userName;

  @HiveField(2)
  String? userImage;

  @HiveField(3)
  String? userPassword;

  @HiveField(4)
  bool? isBlocked;

  UserModel({
    this.name,
    this.userName,
    this.userImage,
    this.userPassword,
    this.isBlocked
  });

}