import 'dart:io';

import 'package:first_project_app/customWidgets/customtextfield.dart';
import 'package:first_project_app/customWidgets/imagecontainer.dart';
import 'package:first_project_app/customWidgets/profileicon_button.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final UserModel? user;
   EditProfile({super.key, this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  
  final nameController = TextEditingController(text: userListNotifier.value[keys.indexOf(userKey!)].name);
  
  final userNameController = TextEditingController(text: userListNotifier.value[keys.indexOf(userKey!)].userName);
  
  final formkey = GlobalKey<FormState>();
  
  File? imagepath;
  String? image = userListNotifier.value[keys.indexOf(userKey!)].userImage ?? '';
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),


      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.yellow.shade100,
            borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50)
            )
        
        
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: ValueListenableBuilder(valueListenable: userListNotifier,
               builder: (
                BuildContext context,
                List<UserModel> userList, 
                 child_){
                  return Padding(
                    padding:const EdgeInsets.only(
                      left: 10,
                      right: 10
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50,),
                        Stack(
                          children: [
                            ImageContainer(
                              condition: image!=null && image!.isNotEmpty ,
                               imageProvider: FileImage(File(image!))),
                               ProfieIconBtn(onTap: (){
                                pickImageFromGallery();
                                })

                          ],
                        ),

                       const SizedBox(height: 20,),

                        Form(
                          key: formkey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                CustomTextField(
                                  mode: AutovalidateMode.onUserInteraction,
                                  hintText: "Enter your Name",
                                  maxLines: 1, 
                                  customController: nameController,
                                  validator: (value){
                                    final trimmedValue = value?.trim();
                                    if(trimmedValue == null || trimmedValue.isEmpty){
                                      return "Name can't be empty";
                                    }else{
                                      return null;
                                    }
                            
                                  },
                                  ),
                            
                                  const SizedBox(height: 10,),
                            
                                  CustomTextField(
                                    hintText: "Enter your UserName", 
                                    customController: userNameController,
                                    mode: AutovalidateMode.onUserInteraction,
                                    maxLines: 1,
                                    validator: (value){
                                      final trimmedvalue = value?.trim();
                                      if(trimmedvalue == null || trimmedvalue.isEmpty){
                                        return "Username can't be Empty";
                                      }else{
                                        return null;
                                      }
                                    },
                                    )
                              ],
                            
                                                    ),
                          )
                        ),

                        SizedBox(height: 20,),

                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStatePropertyAll(Colors.white),
                                backgroundColor: MaterialStatePropertyAll(Colors.orange)
                              ),
                              onPressed: ()async {
                                await updateUser().then((value)=>Navigator.of(context).pop());
                                
                              }, child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text("Edit",style: GoogleFonts.irishGrover(fontSize: 20),),
                              )),
                          ),
                        )
                      ],
                    ),
                    );
                 }),
            ),
          ),
        ),
      ),
    );
  }


  Future pickImageFromGallery()async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnedImage == null) return ;

    setState(() {
      imagepath = File(returnedImage.path);
      image = returnedImage.path;
    });
  }



  Future updateUser()async{
    if(formkey.currentState!.validate()){
      UserModel usermodel = UserModel(
        name: nameController.text.trim(),
        userName: userNameController.text.trim(),
        userImage: image,
        userPassword: widget.user?.userPassword,

      );

      await UserFunctions().editUser(usermodel, int.parse(userKey!)).then((value)=>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile has been successfully edited"),
          duration: Duration(seconds: 3),
          dismissDirection: DismissDirection.startToEnd,
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          
          )));
    }

  }
}