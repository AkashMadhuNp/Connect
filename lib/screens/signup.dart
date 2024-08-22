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
  final confirmpasswordController = TextEditingController();
  bool obscureTextPass = true;
  bool obscureTextPassConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade100,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          //final height = constraints.maxHeight;

          return SingleChildScrollView(
            child: Padding(
              padding:const EdgeInsets.all(16.0),

              child: Column(
                children: [
                  SvgPicture.asset(
                            "assets/undraw_welcome_re_h3d9.svg",
                            height: 200,
                            width: 200,
                          ),
                          const SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: width > 400 ? 400 : width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                              Text(
                                "REGISTER",
                                style: GoogleFonts.irishGrover(
                                  fontSize: 24 * MediaQuery.of(context).textScaleFactor,
                                  color: const Color.fromARGB(255, 185, 128, 41),
                                ),
                              ),
                              Text(
                                "Create your Account",
                                style: GoogleFonts.irishGrover(
                                  fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                                  color:const Color.fromARGB(255, 117, 117, 116),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: userNameController,
                                validator: (value) {
                                  final trimmedValue = value?.trim();
                                  if (trimmedValue == null || trimmedValue.isEmpty) {
                                    return "UserName can't be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "UserName",
                                  hintStyle: GoogleFonts.irishGrover(
                                    fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_2_rounded, 
                                    size: 24 * MediaQuery.of(context).textScaleFactor
                                    ),
                                  border:const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
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
                                  } else if (!RegExp(r'[A-Z]').hasMatch(value) || !RegExp(r'[0-9]').hasMatch(value)) {
                                    return 'Password must contain at least one uppercase letter and one number';
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: obscureTextPass,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  errorMaxLines: 5,
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.irishGrover(
                                    fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                                  ),
                                  prefixIcon: Icon(Icons.lock_rounded, size: 24 * MediaQuery.of(context).textScaleFactor),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureTextPass ? Icons.visibility_off : Icons.visibility,
                                      size: 24 * MediaQuery.of(context).textScaleFactor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        obscureTextPass = !obscureTextPass;
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
                                controller: confirmpasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Confirm Password can't be empty";
                                  } else if (passwordController.text.trim() != value.trim()) {
                                    return "Passwords should match";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: obscureTextPassConfirm,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  contentPadding:const EdgeInsets.all(20),
                                  prefixIcon: Icon(Icons.lock_rounded, size: 24 * MediaQuery.of(context).textScaleFactor),
                                  fillColor: Colors.white,
                                  filled: true,
                                  errorMaxLines: 5,
                                  hintText: "Confirm Password",
                                  hintStyle: GoogleFonts.irishGrover(
                                    fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureTextPassConfirm ? Icons.visibility_off : Icons.visibility,
                                      size: 24 * MediaQuery.of(context).textScaleFactor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        obscureTextPassConfirm = !obscureTextPassConfirm;
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
                              SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.black),
                                    foregroundColor: MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      bool alreadyExist = await UserFunctions()
                                          .checkUserExist(userNameController.text.trim());
                  
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
                                    }
                                  },
                                  child: Text(
                                    "SIGN UP",
                                    style: GoogleFonts.irishGrover(
                                      color: Colors.white,
                                      fontSize: 20 * MediaQuery.of(context).textScaleFactor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> signUp() async {
    UserModel user = UserModel(
      userName: userNameController.text.trim(),
      userPassword: passwordController.text.trim(),
      isBlocked: false,
    );

    await UserFunctions()
        .addUser(user)
        .then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const CreateProfile())));
  }
}