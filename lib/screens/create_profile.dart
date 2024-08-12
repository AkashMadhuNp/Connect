import 'dart:io';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:first_project_app/screens/home/home_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

  final nameController = TextEditingController();
  final userNameCOntroller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  File? imagepath;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade100,
      ),
      backgroundColor: Colors.yellow.shade100,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text("Create Your Profile",style: GoogleFonts.irishGrover(fontSize:24,color: Colors.black,fontWeight: FontWeight.bold ),),
             const SizedBox(height:40),
              Text("Take a step forward to feel \n more organized",textAlign: TextAlign.center,style: GoogleFonts.irishGrover(color: Colors.black87,fontSize: 18,letterSpacing: 2),),
               const SizedBox(height: 50,),
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color:  Color.fromARGB(255, 71, 50, 77), width: 3.0),
                    ),
                    child: CircleAvatar(
                      backgroundImage: imagepath != null
                          ?FileImage(imagepath!)
                          :const AssetImage("assets/profile_icon.jpg")
                          as ImageProvider
                    ),


                  ),
                  Padding(padding:const EdgeInsets.only(left: 104,top: 104),
                  child: IconButton(
                      onPressed: () async {
                        await pickImageFromGallery();
                      },
                      icon: const Icon(Icons.add_a_photo,size: 30,color: Colors.black,)),
                  ),

                 const SizedBox(height: 20,),




                ],
              ),


               Form(
                 key: formkey,
                 child: Padding(
                   padding: const EdgeInsets.all(30.0),
                   child: TextFormField(
                     autovalidateMode: AutovalidateMode.onUserInteraction,
                     controller:nameController,
                     decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                       hintText: "Enter your Name",
                       hintStyle: GoogleFonts.irishGrover(),
                       fillColor: Colors.white,
                       filled: true,
                       border: OutlineInputBorder(
                         borderSide: BorderSide.none,
                         borderRadius: BorderRadius.circular(30),
                       )
                     ),
                     validator: (value){
                       final trimmedValue = value?.trim();
                       if(trimmedValue == null || trimmedValue.isEmpty){
                         return "Name can't be empty";
                       }else{
                         return null;
                       }
                     },
                   )
                 ),
               ),

//BUTTON

               Padding(
                          padding: const EdgeInsets.only(right: 30.0,left: 30,top: 15),
                          child: SizedBox(height: 60,width: double.infinity,
                          child: ElevatedButton(

                            style:const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                              foregroundColor: MaterialStatePropertyAll(Colors.white)

                            ),
                            onPressed: () async{
                              bool data = await registeredUser();
                              if(data){
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeNavPage(),), (route) => false,);
                              }


                          }, child: Text("Set Profile",style:GoogleFonts.irishGrover(color: Colors.white,fontSize: 20),)),
                          ),


                        ),




                        Padding(
                          padding: const EdgeInsets.only(right: 30.0,left: 30,top: 15),
                          child: SizedBox(height: 60,width: double.infinity,
                          child: ElevatedButton(

                            style:const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                              foregroundColor: MaterialStatePropertyAll(Colors.white)

                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const HomeNavPage(),));

                          }, child: Text("I'll do it Later",style:GoogleFonts.irishGrover(color: Colors.white,fontSize: 20),)),
                          ),


                        ),

            ],
          ),
        ),
      ),
    );
  }




Future pickImageFromGallery()async{
final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
if(returnedImage == null) return;
setState(() {
  imagepath = File(returnedImage.path);
  image = returnedImage.path;
});
}


  




  registeredUser()async{
    if(formkey.currentState!.validate()){
      await UserFunctions().addProfile(UserModel(
        name: nameController.text.trim(),userImage: imagepath?.path
      ));
      return true;
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("field can't be empty" )));
return false;
    }
  }
}