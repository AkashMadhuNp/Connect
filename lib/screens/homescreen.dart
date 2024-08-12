import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/screens/home/home_nav.dart';
import 'package:first_project_app/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool obsecureText = true;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initializePreferences();
    initializeUser();
  }

  Future<void> initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void resetForm() {
    setState(() {
      userNameController.clear();
      passwordController.clear();
      formKey.currentState?.reset(); // This resets the form's validation state
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.yellow.shade100,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 140),
                  SvgPicture.asset(
                    "assets/undraw_welcome_re_h3d9.svg",
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "LOGIN",
                    style: GoogleFonts.irishGrover(
                      fontSize: 24,
                      color: const Color.fromARGB(255, 185, 128, 41),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 350,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "UserName",
                                hintStyle: GoogleFonts.irishGrover(),
                                suffixIcon: const Icon(Icons.person_2_rounded),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              obscureText: obsecureText,
                              controller: passwordController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Password",
                                hintStyle: GoogleFonts.irishGrover(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obsecureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obsecureText = !obsecureText;
                                    });
                                  },
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30.0, left: 30, top: 15),
                              child: SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState?.validate() ?? false) {
                                      final checkVariable =
                                          await UserFunctions().validateUserLogin(
                                        userNameController.text.trim(),
                                        passwordController.text.trim(),
                                      );
      
                                      if (checkVariable != null) {
                                        await UserFunctions().getCurrentUserKey();
                                        await UserFunctions().checkUserLoggedIn(
                                          true,
                                          userKey!,
                                        ).then((value) => Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                       HomeNavPage(),
                                                ),
                                                (route) => false));
                                      } else {
                                        showSnackBar(context, "Invalid username or password");
                                      }
                                    }
                                  },
                                  child: Text(
                                    "LOGIN",
                                    style: GoogleFonts.irishGrover(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: GoogleFonts.irishGrover(
                                      fontWeight: FontWeight.w400),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) => const SignupPage(),
                                      ),
                                    )
                                        .then((_) {
                                      resetForm();
                                    });
                                  },
                                  child: const Text("Sign Up"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange,
      content: Text(message),
    ));
  }

  Future<void> initializeUser() async {
    await UserFunctions().getCurrentUserKey();
  }
}