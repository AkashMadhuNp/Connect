import 'dart:io';

import 'package:first_project_app/customWidgets/calertbox.dart';
import 'package:first_project_app/customWidgets/cimagepopup.dart';
import 'package:first_project_app/customWidgets/imagecontainer.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/screens/homescreen.dart';
import 'package:first_project_app/screens/perfomance/change_password.dart';
import 'package:first_project_app/screens/perfomance/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          
        ),
        title:  Text("Profile",style: GoogleFonts.irishGrover(fontWeight: FontWeight.w600,letterSpacing: 3),),
        centerTitle: true,
      ),


      body: SingleChildScrollView(
        child: Container(
          child: ValueListenableBuilder(
            valueListenable: userListNotifier, 
            builder: (context, value, child){
              return Column(
                children: [
                  const SizedBox(height: 30,),
                  ImagePopUp(
                    condition:value[int.parse(userKey!)].userImage !=null , 
                    child2: value[int.parse(userKey!)].userImage!=null
                    ? Image.file(File(value[int.parse(userKey!)].userImage!)):Image.asset(""), 
                    child: ImageContainer(
                      condition: value[int.parse(userKey!)].userImage != null 
                      && value[int.parse(userKey!)].userImage!='', 
                      imageProvider: FileImage(
                        File(value[int.parse(userKey!)].userImage ?? ''),
                      )
                      )
                    ),

                    const SizedBox(height: 20,),

                    Center(
                       child: value[int.parse(userKey!)].name != null
                       ? Text(value[int.parse(userKey!)].name ?? '',
                       style: GoogleFonts.irishGrover(),
                       
                       ):null,
                    ),

                    const SizedBox(height: 10,),


                    Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(padding: EdgeInsets.all(16),
                      child: Text("General Settings",style: GoogleFonts.irishGrover(color: Colors.white,),),
                      ),
                    ),

                    ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile(),));
                      } ,
                      leading:Icon(Icons.edit) ,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Text("Edit Profile",style: GoogleFonts.irishGrover(),),
                      ),
                    ),

                    Divider(thickness: 1,),

                    ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword(),));
                      } ,
                      leading:Icon(Icons.password_rounded) ,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Text("Change Password",style: GoogleFonts.irishGrover(),),
                      ),
                    ),


                    const Divider(thickness: 1,),

                    ListTile(
                      onTap: (){
                        showDialog(context: context, 
                        builder:(context) {
                          return CustomAlertBox(text: "Areyou sure you want to delete this Account?", 
                          title:"Delete Account ?", 
                          onpressedCancel: () {
                            Navigator.of(context).pop();
                          }, 
                          onpressedDelete: () async {
                            await UserFunctions().blockUser(int.parse(userKey!)).then((value)=>Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),), 
                                (route) => false,
                                ));
                            
                          }, okText: "Delete Account");
                        },);
                      },

                      leading: Icon(Icons.person_off),
                      title: Padding(padding: EdgeInsets.only(left: 28),
                      child: Text("Delete Account"),
                      ),
                    )







                  

                ],

              );
            } ,),

        ),
      ),
    );
  }
}