
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:first_project_app/screens/home/home_nav.dart';
import 'package:first_project_app/screens/home/home_page.dart';
import 'package:first_project_app/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin 
{

  late  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync:this,
    duration: Duration(milliseconds: 750),
    );
    initialCurrentUser();

  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/splash.json",
        repeat: true,
        width: 250,
        height: 250,
        onLoaded: (con){
          controller.duration = con.duration;
          controller.forward().whenComplete(isUserRegistered);
        }
        ),
      ),
    );
  }


  Future<void> isUserRegistered()async{
    bool checkUser = await UserFunctions().checkUser();
    bool isLoggedIn = await UserFunctions().isLoggedIn();
    await UserFunctions().getUser();
    if(checkUser == false){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
    }else if(isLoggedIn == true){
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeNavPage(),));
      }
    }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      }
      }

      Future initialCurrentUser()async{
        await UserFunctions().getCurrentUserKey();
      }

      initializeuser() async{
        UserModel? user = await UserFunctions().getCurrentUser(userKey!);
        return user;
      }
}