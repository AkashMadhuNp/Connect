
import 'package:first_project_app/class/icon_class.dart';
import 'package:first_project_app/db_Functions/category_db.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/model/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


List<ValueNotifier<double>> iconnotifier =[];

class CustomDialogBox extends StatefulWidget {

   CustomDialogBox({super.key});

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {

  final categoryController = TextEditingController();
  final categoryIconController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  IconData? selectedIcon;

 
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      ),


      child:  SizedBox(
        height: 350,
        width: double.minPositive,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 20,top: 20),
            child: Text("Task Type",style: GoogleFonts.irishGrover(
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
            ),
            ),



            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: categoryController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                   validator: (value) {
                    final trimmedValue = value?.trim();
                    if (trimmedValue == null || trimmedValue.isEmpty) {
                      return 'location can\'t be empty';
                    } else {
                      return null;
                    }
                  },
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2
                      )
                    ),
                    hintText: "Enter title here!"
                  ),
                )),

              ),


              Expanded(
                child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4), 
                  itemBuilder: (context, index) {
                     iconnotifier.add(ValueNotifier<double>(20));
                     return ValueListenableBuilder(
                      valueListenable: iconnotifier[index], 
                      builder: (context, sizevalue, _) {
                        return IconButton(
                          onPressed: () {
                            for(var elements in iconnotifier){
                              elements.value = 20.0;
                              setState(() {
                                
                              });
                            }
                            iconnotifier[index].value=40.0;
                            
                            selectedIcon = icons[index].icon;
                          }, 
                          icon: Icon(
                            icons[index].icon,
                            size: sizevalue,
                            color: icons[index].color,));

                      });
                      },
                  itemCount: icons.length,
                  ),
                  
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(onPressed: () {
                       Navigator.of(context).pop(); 
                      }, child: Text("Cancel",style: GoogleFonts.irishGrover(
                        color: Colors.black,
                        fontSize: 15
                      ),)),


                      TextButton(
                        onPressed: addCategoryOnPressed,
                       child: Text("Add",
                      style:GoogleFonts.irishGrover(
                        color: Colors.black,
                        fontSize: 15
                      ),))
                    ],
                  ),

                  const SizedBox(height: 20,),




                  
          ],

        ),
      ),
    );
  }


  String iconDataToString(IconData icon){
    return "${icon.fontFamily}--${icon.codePoint}";

  }




  Future addCategoryOnPressed()async{
    if(formKey.currentState !=null && formKey.currentState!.validate()){
      bool categoryExists = await CategoryFunction().checkCategoryExists(categoryController.text.trim());
      if(categoryExists == false){
        CategoryModel category = CategoryModel(

          categoryTitle: categoryController.text.trim(), 
          categoryIcon: selectedIcon != null
          ? iconDataToString(selectedIcon!)
          : null , 
          done: false, 
          userkey: userKey!);

          await CategoryFunction().addCategory(category);
          await CategoryFunction().currentUserCategory(userKey!).
          then((value)=>Navigator.of(context).pop());
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Unable to create category, Category already Exists"),
          duration: Duration(seconds: 3),
          dismissDirection: DismissDirection.startToEnd,
          margin: const EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          
          ));
      }
    }
  }
}