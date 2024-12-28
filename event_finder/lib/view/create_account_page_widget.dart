// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import

import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:event_finder/view/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

Future<void> saveUserId(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

class CreateAccountPageWidget extends StatefulWidget {
  const CreateAccountPageWidget({super.key});

  @override
  _CreateAccountPageWidgetState createState() =>
      _CreateAccountPageWidgetState();
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
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'lib/res/assets/images/logogoova.png',
                    height: 120, 
                    width: 120,
                  ),
                  const SizedBox(height: 10),
                  Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "and Unlock Event Creation on Goova!",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: nameTextController,
                    focusNode: textFieldFocusNode1,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      prefixIcon: Icon(
                        Icons.person_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: emailTextController,
                    focusNode: textFieldFocusNode2,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                    ),
                    ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordTextController,
                    obscureText: !passwordVisibility,
                    focusNode: textFieldFocusNode3,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              passwordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                      onPressed: () async {
                        final authViewModel =
                            Provider.of<AuthViewModel>(context, listen: false);

                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Membuat dialog tidak bisa ditutup saat loading
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircularProgressIndicator(),
                                    SizedBox(width: 20),
                                    Text('Processing...'), // Teks loading
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        // Validasi form input
                        if (nameTextController.text.isEmpty) {
                          Navigator.of(context).pop(); // Menutup dialog loading
                          Utils.toastMessage('Please Enter Name');
                        } else if (emailTextController.text.isEmpty) {
                          Navigator.of(context).pop(); // Menutup dialog loading
                          Utils.toastMessage('Please Enter Email');
                        } else if (passwordTextController.text.isEmpty) {
                          Navigator.of(context).pop(); // Menutup dialog loading
                          Utils.toastMessage('Please Enter Password');
                        } else if (passwordTextController.text.length < 6) {
                          Navigator.of(context).pop(); // Menutup dialog loading
                          Utils.toastMessage('Please Enter 6 Digit Password');
                        } else {
                          // Membuat data yang akan dikirim ke API
                          Map<String, dynamic> data = {
                            'name': nameTextController.text.toString(),
                            'email': emailTextController.text.toString(),
                            'password': passwordTextController.text.toString(),
                          };

                          // Panggil fungsi register API
                          await authViewModel.registerApi(data, context);

                          // Menutup dialog loading setelah proses selesai
                          Navigator.of(context).pop(); // Menutup dialog

                          // Pindah ke halaman admin event setelah registrasi selesai
                          Navigator.pushNamed(
                              context, RoutesName.login);
                          print('api hit');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary, // Background color
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Sign Up"),
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
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: "Log In",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ),
    ),
    ),
    );
  }
}
