// ignore_for_file: prefer_const_constructors

import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          child: Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
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
                        "Welcome Back!",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Ready to Create Your Next Event?",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: emailTextController,
                        focusNode: textFieldFocusNode1,
                        decoration: InputDecoration(
                          hintText: "Email Address",
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
                        focusNode: textFieldFocusNode2,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          filled: true, 
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(12) 
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purple, width: 2),
                                borderRadius: BorderRadius.circular(12) 
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          // Menampilkan dialog loading saat proses login
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
                          if (emailTextController.text.isEmpty) {
                            Navigator.of(context)
                                .pop(); // Menutup dialog loading
                            Utils.toastMessage('Please Enter Email');
                          } else if (passwordTextController.text.isEmpty) {
                            Navigator.of(context)
                                .pop(); // Menutup dialog loading
                            Utils.toastMessage('Please Enter Password');
                          } else if (passwordTextController.text.length < 6) {
                            Navigator.of(context)
                                .pop(); // Menutup dialog loading
                            Utils.toastMessage('Please Enter 6 Digit Password');
                          } else {
                            Map<String, dynamic> data = {
                              'email': emailTextController.text.toString(),
                              'password':
                                  passwordTextController.text.toString(),
                            };

                            // Panggil fungsi login API dan pastikan untuk menutup dialog dan navigasi setelahnya
                            await authViewModel.loginApi(data, context,
                                onSuccess: () {
                              Navigator.of(context)
                                  .pop(); // Menutup dialog loading
                            });

                            print('api hit');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Log In"),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.register);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don’t have an account? ",
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
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
              // Tambahkan tombol di pojok kiri atas
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.home);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.purple, // Warna background
                      shape: BoxShape.circle, // Membuat bentuk lingkaran
                    ),
                    child: Center(
                      child: Image.asset(
                        'lib/res/assets/images/home.png', // Path ke ikon lokal
                        height: 25, // Ukuran ikon
                        width: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
