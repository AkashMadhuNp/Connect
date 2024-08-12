import 'package:first_project_app/customWidgets/passwordfield.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  
  final formkey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obsecureText1 = true;
  bool obsecureText2 = true;
  bool obsecureText3 = true;
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
         leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        title:  Text("Change Password",style: GoogleFonts.irishGrover(fontWeight: FontWeight.w600,letterSpacing: 3,color: Colors.white),),
        centerTitle: true,
        
      ),


      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              const SizedBox(height: 50,),

              PasswordField(controller: oldPasswordController,
               mode: AutovalidateMode.onUserInteraction, 
               validator: (value){
                if(value == null || value.isEmpty){
                  return "Password can't be empty";
                }else if(oldPasswordController.text.trim()!= userListNotifier.value[int.parse(userKey!)].userPassword){
                  return "Incorrect Password";
                }else{
                  return null;
                }
               }, 
               icon: obsecureText1 == true 
               ? Icons.visibility_off
               : Icons.visibility, 
               
               obsecureText: obsecureText1,
                onPressed: () {
                  setState(() {
                    obsecureText1 =! obsecureText1;
                  });
                }, 
                hintText: "Old Password"
                ),



                PasswordField(
                  controller: newPasswordController, 
                  mode: AutovalidateMode.onUserInteraction, 
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please fill the field";
                    }else if(value.length < 8){
                      return "The password must contain atleast 8 characters";
                    }else if(!RegExp(r'[A-Z]').hasMatch(value) ||
                        !RegExp(r'[0-9]').hasMatch(value)){
                          return "Password must contain one uppercase letter and one number";
                        }else{
                          return null;
                        }
                  },
                   icon: obsecureText2 
                   ?Icons.visibility_off
                   :Icons.visibility, 
                   obsecureText: obsecureText2, 
                   onPressed: () {
                     setState(() {
                       obsecureText2 =!obsecureText2;
                     });
                   }, 
                   hintText: "New Password"),


                   PasswordField(
                    controller: confirmPasswordController, 
                    mode: AutovalidateMode.onUserInteraction, 
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return " Please fill the field";
                      }else if(confirmPasswordController.text.trim()!=newPasswordController.text.trim()){
                        return "new password and confirm password should match";
                      }else{
                        return null;
                      }
                    }, 


                    icon: obsecureText3 
                    ? Icons.visibility_off
                    : Icons.visibility, 
                    obsecureText: obsecureText3, 
                    onPressed: () {
                      setState(() {
                        obsecureText3 = !obsecureText3;
                      });
                    }, 
                    hintText: "Confirm Password"),

                    SizedBox(height: 20,),

                    SizedBox(
                        width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(50),
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async{
                              await editButton().then((value)=>ScaffoldMessenger(
                                child: SnackBar(
                                  content: Text("Password has successfully changed"),
                                  duration: Duration(
                                    seconds: 3
                                  ),
                                  dismissDirection: DismissDirection.startToEnd,
                                  margin: EdgeInsets.all(20),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  )));
                              
                            },
                            child: Text("Edit",style: GoogleFonts.irishGrover(fontSize:20  ),),
                          ),
                      ),
                      )

            ],


          )),
      ),

    );
  }

  Future<void> editButton()async{
    if(formkey.currentState!.validate()){
      await UserFunctions().changePassword(UserModel(
        userPassword: confirmPasswordController.text.trim())).
      then((value)=>Navigator.of(context).pop());
    }
  }
}
