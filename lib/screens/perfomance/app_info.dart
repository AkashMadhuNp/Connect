import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
     backgroundColor: Colors.orange,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, 
        
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          )),
          title: Text("About CONNECT",style: GoogleFonts.irishGrover(
            color: Colors.white,
            fontSize: 25,
            letterSpacing: 2
          ),
          
          ),
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.yellow.shade100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
          )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              
              children: [
                SizedBox(height: 10,),
                Image.asset("assets/conlogo-removebg-preview.png",height: 240,),
                Text("'Introducing CONNECT - Your Personal Day Planner!\n\nStay on top of your busy schedule with \nConnect - the ultimate task manager and day planner. Effortlessly schedule tasks, categorize them for easy organization, and receive timely notifications to keep you on track. Plan your day ahead with the intuitive calendar feature.\n\n Download Connect now and take control of your time like never before!",
                style: GoogleFonts.irishGrover(
                  fontSize: 15
                ),
                textAlign: TextAlign.justify,
                ),

                SizedBox(height: 40,),


                Text("POWERED BY : AKASH-MADHU",
                style: GoogleFonts.irishGrover(
                  color: Colors.grey,
                  

                ),)
                
          
              ],
            ),
          ),
        ),
      
      ),
    );
  }
}