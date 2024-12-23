// ignore_for_file: prefer_const_constructors, unused_local_variable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  // Controllers and FocusNodes
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final textFieldFocusNode1 = FocusNode();
  final textFieldFocusNode2 = FocusNode();

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    emailTextController.dispose();
    passwordTextController.dispose();
    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();
    super.dispose();
  }

  // Password visibility state
  bool passwordVisibility = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            shadowColor: Colors.blue[200],
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Login to Create Event",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'lib/res/assets/images/logo.png', 
                    height: 150,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: emailTextController,
                    focusNode: textFieldFocusNode1,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      prefixIcon: Icon(Icons.email, color: Colors.blue[700]),
                      filled: true,
                      fillColor: Colors.blue[50],
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordTextController,
                    focusNode: textFieldFocusNode2,
                    obscureText: !passwordVisibility,
                    // obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
                      filled: true,
                      fillColor: Colors.blue[50],
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () async{
                      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

                                      // Fungsi login dari AuthViewModel.
                                      if (emailTextController.text.isEmpty) {
                                        Utils.toastMessage('Please Enter Email');
                                      } else if (passwordTextController.text.isEmpty) {
                                        Utils.toastMessage('Please Enter Password');
                                      } else if (passwordTextController.text.length < 6) {
                                        Utils.toastMessage('Please Enter 6 Digit Password');
                                      } else {
                                        Map data = {
                                          'email' : emailTextController.text.toString(),
                                          'password' : passwordTextController.text.toString(),
                                        };

                                        authViewModel.loginApi(data, context);
                                        print('api hit');
                                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.register); 
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don’t have an account? ",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
    );
  }
}                                           