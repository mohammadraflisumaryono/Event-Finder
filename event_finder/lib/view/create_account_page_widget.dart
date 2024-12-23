// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class CreateAccountPageWidget extends StatefulWidget {
  const CreateAccountPageWidget({super.key});

  @override
  _CreateAccountPageWidgetState createState() => _CreateAccountPageWidgetState();
}

class _CreateAccountPageWidgetState extends State<CreateAccountPageWidget> {
    // Controllers and FocusNodes
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final textFieldFocusNode1 = FocusNode();
  final textFieldFocusNode2 = FocusNode();
  final textFieldFocusNode3 = FocusNode();

  // Password visibility state
  bool passwordVisibility = false;

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    nameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();
    textFieldFocusNode3.dispose();
    super.dispose();
  }

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
                      "Wanna up some event?",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Sign up to get started",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'lib/res/assets/images/logo.png', // Add the relevant image to assets folder
                    height: 150,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: nameTextController,
                    focusNode: textFieldFocusNode1,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      prefixIcon: Icon(Icons.person, color: Colors.blue[700]),
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
                    controller: emailTextController,
                    focusNode: textFieldFocusNode2,
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
                    obscureText: !passwordVisibility,
                    focusNode: textFieldFocusNode3,
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
                    onPressed: () async {
                      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

                        // Fungsi login dari AuthViewModel.
                        if (nameTextController.text.isEmpty) {
                          Utils.toastMessage('Please Enter Name');
                        } else if (emailTextController.text.isEmpty) {
                          Utils.toastMessage('Please Enter Email');
                        } else if (passwordTextController.text.isEmpty) {
                          Utils.toastMessage('Please Enter Password');
                        } else if (passwordTextController.text.length < 6) {
                          Utils.toastMessage('Please Enter 6 Digit Password');
                        } else {
                          Map <String, dynamic> data = {
                            'name' : nameTextController.text.toString(),
                            'email' : emailTextController.text.toString(),
                            'password' : passwordTextController.text.toString(),
                          };

                          authViewModel.registerApi(data, context);
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
                      "Sign Up",
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
                        Navigator.pushNamed(context, RoutesName.login);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14,
                          ),
                          // children: [
                          //   TextSpan(
                          //     text: "Log In",
                          //     style: TextStyle(
                          //       color: Colors.blue[700],
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ],
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