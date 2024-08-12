

import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:first_project_app/screens/create_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassword = TextEditingController();
  bool obsecureTextPass = true;
  bool obsecureTextPassConfirm = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade100,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.yellow.shade100,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                SvgPicture.asset(
                  "assets/undraw_welcome_re_h3d9.svg",
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  "REGISTER",
                  style: GoogleFonts.irishGrover(
                    fontSize: 24,
                    color: const Color.fromARGB(255, 185, 128, 41),
                  ),
                ),
                Text(
                  "Create your Account",
                  style: GoogleFonts.irishGrover(
                    fontSize: 18,
                    color: Color.fromARGB(255, 117, 117, 116),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                      child: Column(
                        children: [
                         TextFormField(
                          
                          controller: userNameController,
                          validator: (value){
                            final trimmedValue = value?.trim();
                            if(trimmedValue==null||trimmedValue.isEmpty){
                              return "UserName can't be empty";
                            }else{
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "UserName",
                            hintStyle: GoogleFonts.irishGrover(),
                            prefixIcon: Icon(Icons.person_2_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50))
                            )

                          ),
                         ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password can't be empty";
                              } else if (value.length < 8) {
                                return "The password must contain at least 8 characters";
                              } else if (!RegExp(r'[A-Z]').hasMatch(value) || 
                                         !RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Password must contain at least one uppercase letter and one number';
                              } else {
                                return null;
                              }
                            },
                            obscureText: obsecureTextPass,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              errorMaxLines: 5,
                              hintText: "Password",
                              hintStyle: GoogleFonts.irishGrover(),
                              prefixIcon: Icon(Icons.lock_rounded),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obsecureTextPass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obsecureTextPass = !obsecureTextPass;
                                  });
                                },
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            
                            controller: confirmpassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirm Password can't be empty";
                              } else if (passwordController.text.trim() != confirmpassword.text.trim()) {
                                return "Passwords should match";
                              } else {
                                return null;
                              }
                            },
                            obscureText: obsecureTextPassConfirm,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              prefixIcon: Icon(Icons.lock_rounded),
                              fillColor: Colors.white,
                              filled: true,
                              errorMaxLines: 5,
                              hintText: "Confirm Password",
                              hintStyle: GoogleFonts.irishGrover(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obsecureTextPassConfirm
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obsecureTextPassConfirm = !obsecureTextPassConfirm;
                                  });
                                },
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0, left: 30, top: 15),
                            child: SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.black),
                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () async {
                                  bool alreadyExist = await UserFunctions().checkUserExist(userNameController.text.trim());

                                  if (alreadyExist) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Center(
                                          child: Text('Username already taken'),
                                        ),
                                      ),
                                    );
                                  } else {
                                    await signUp();
                                  }
                                },
                                child: Text(
                                  "SIGN UP",
                                  style: GoogleFonts.irishGrover(color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40), // Add some bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      UserModel user = UserModel(
        userName: userNameController.text.trim(),
        userPassword: passwordController.text.trim(),
        isBlocked: false,
      );

      await UserFunctions().addUser(user).then((value) => Navigator.of(context)
          .push(
              MaterialPageRoute(builder: (context) => CreateProfile())));
    }
  }
}
