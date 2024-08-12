import 'package:first_project_app/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);
ValueNotifier<String?> currentNotifier = ValueNotifier('');


String? userKey;
List<String> keys = [];


class UserFunctions extends ChangeNotifier {
  
  Future<void> addUser(UserModel value) async {
  final Box<UserModel> userVariable = await Hive.openBox<UserModel>('user_db');
  try {
    int key = await userVariable.add(value);
    userKey = key.toString();
    await saveCurrentUser(userKey!);
    await getUser();
    print('User added: ${value.userName} with key $userKey');
  } catch (e) {
    print('Error adding user: $e');
  } finally {
    await userVariable.close(); 
  }
}


  Future getUser()async{
    final userVariable = await Hive.openBox<UserModel>('user_db');
    keys.clear();
    keys.addAll(userVariable.keys.map((e)=>e.toString()).toList());
    userListNotifier.value.clear();
    userListNotifier.value.addAll(userVariable.values);
    userListNotifier.notifyListeners();
    await userVariable.close();
  }


Future<void> saveCurrentUser(String key) async {
  try {
    print('Attempting to save current user with key: $key');
    Box<String> keydata = await Hive.openBox<String>('current_userKey');
    await keydata.put("currentUserKey", key);
    print('Key saved in Hive box: ${keydata.get("currentUserKey")}');
    await keydata.close();
    print('current_userKey box closed');
    String? retrievedKey = await getCurrentUserKey();
    print('Retrieved current user key: $retrievedKey');
  } catch (e) {
    print('Error saving current user key: $e');
  }
}


  Future<UserModel?> getCurrentUser(String key)async{
    final Box<UserModel> userVariable = await Hive.openBox<UserModel>('user_db');
    return userVariable.get(int.parse(key));
  }


  Future<String?> getCurrentUserKey()async{
    Box<String> box= await Hive.openBox('current_userKey');
    String? key = box.get('currentUserKey');
    userKey = key;
    return userKey;
  }


  Future<bool> checkUser()async{
    final userVaraible = await Hive.openBox<UserModel>('user_db');
    keys.clear();
    keys.addAll(userVaraible.keys.map((e)=>e.toString()).toList());

    var l = userVaraible.length;
    await userVaraible.close();
    if(l >= 1){
      return true;
    }
    return false;
  }


  Future<bool> checkUserExist(String userNameEntered) async{
    final Box<UserModel> users = await Hive.openBox<UserModel>('user_db');
    List<UserModel> allUsers = users.values.toList();
    bool existUser = allUsers.any((element)=> element.userName == userNameEntered);
    await users.close();
    return existUser;
  }


Future<String?> validateUserLogin(String userName, String Password) async {
    final Box<UserModel> user = await Hive.openBox<UserModel>('user_db');
    try {
      if (user.isEmpty) {
        return null;
      } else {
        UserModel? matchUser = user.values.firstWhere(
          (element) =>
              element.userName == userName &&
              element.userPassword == Password &&
              element.isBlocked == false,
          orElse: () => UserModel(),
        );
        if (matchUser.isInBox) {
          int? key2 = matchUser.key;
          if (key2 != null) {
            await saveCurrentUser(key2.toString());
            userKey = key2.toString(); // Set userKey here
            return key2.toString();
          }
        }
        return null;
      }
    } finally {
      await user.close();
    }
  }

  Future<bool> checkUserLoggedIn(bool isLoggedIn, String key)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isLoggedIn = pref.getBool('isLoggedIn');
    return isLoggedIn ?? false;
  }


  Future<bool> isLoggedIn()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isLoggedIn=pref.getBool('isLoggedIn');
    return isLoggedIn ?? false;

  }


  Future addProfile(UserModel user)async{
    Box<UserModel> user1 = await Hive.openBox<UserModel>('user_db');
    UserModel? currentuser = await getCurrentUser(userKey!);
    currentuser!.userImage = user.userImage;
    currentuser.name = user.name;

    await user1.put(int.parse(userKey!), currentuser);
    await user1.close();
    await getUser();

  }


  Future editUser(UserModel value, int key)async{
    final userVariable = await Hive.openBox<UserModel>('user_db');
    await userVariable.putAt(key, value);
    await userVariable.close();
    await getUser();
  }


  Future blockUser(int key)async{
    final Box<UserModel> users = await Hive.openBox<UserModel>('user_db');
    UserModel userModel = UserModel(isBlocked: true);
    await users.put(key, userModel);  
  }

  Future changePassword(UserModel user)async{
    Box<UserModel> user1 = await Hive.openBox<UserModel>('user_db');
    UserModel? currentUser = await getCurrentUser(userKey!);
    currentUser!.userPassword = user.userPassword;
    await user1.put(int.parse(userKey!), currentUser);
    await user1.close();
    await getUser();


  }

}