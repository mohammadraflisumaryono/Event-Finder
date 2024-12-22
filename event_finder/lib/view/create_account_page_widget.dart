// ignore_for_file: unused_import, unnecessary_import, use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors, unused_local_variable

import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:event_finder/utils/utils.dart';
import 'package:event_finder/view_model/auth_view_model.dart';
import 'package:go_router/go_router.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateAccountPageWidget extends StatefulWidget {
  const CreateAccountPageWidget({super.key});

  @override
  State<CreateAccountPageWidget> createState() =>
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(0, -1),
            child: Image.network(
              'https://images.unsplash.com/photo-1559066653-edfd1e6bbbd5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2167&q=80',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 180, 0, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 20),
                              child: Image.asset(
                                'assets/images/logo_flutterMet@2x.png',
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // Email TextField
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 4, 15),
                                  child: Container(
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE0E0E0),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 20, 0),
                                      child: TextFormField(
                                        controller: emailTextController,
                                        focusNode: textFieldFocusNode1,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          hintStyle: GoogleFonts.getFont(
                                            'Open Sans',
                                            color: const Color(0x7F455A64),
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: GoogleFonts.getFont(
                                          'Open Sans',
                                          color: const Color(0xFF455A64),
                                          fontWeight: FontWeight.normal,
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Field cannot be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                // Password TextField
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 4, 20),
                                  child: Container(
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE0E0E0),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 20, 0),
                                      child: TextFormField(
                                        controller: passwordTextController,
                                        focusNode: textFieldFocusNode2,
                                        obscureText: !passwordVisibility,
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: GoogleFonts.getFont(
                                            'Open Sans',
                                            color: const Color(0x7F455A64),
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                              () => passwordVisibility =
                                                  !passwordVisibility,
                                            ),
                                            focusNode:
                                                FocusNode(skipTraversal: true),
                                            child: Icon(
                                              passwordVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                        style: GoogleFonts.getFont(
                                          'Open Sans',
                                          color: const Color(0xFF455A64),
                                          fontWeight: FontWeight.normal,
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Field cannot be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                // Create Account Button
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      final authViewModel =
                                          Provider.of<AuthViewModel>(context,
                                              listen: false);

                                      // Fungsi login dari AuthViewModel.
                                      if (nameTextController.text.isEmpty) {
                                        Utils.toastMessage('Please Enter Name');
                                      } else if (emailTextController
                                          .text.isEmpty) {
                                        Utils.toastMessage(
                                            'Please Enter Email');
                                      } else if (passwordTextController
                                          .text.isEmpty) {
                                        Utils.toastMessage(
                                            'Please Enter Password');
                                      } else if (passwordTextController
                                              .text.length <
                                          6) {
                                        Utils.toastMessage(
                                            'Please Enter 6 Digit Password');
                                      } else {
                                        Map data = {
                                          'name': nameTextController.text
                                              .toString(),
                                          'email': emailTextController.text
                                              .toString(),
                                          'password': passwordTextController
                                              .text
                                              .toString(),
                                        };

                                        authViewModel.registerApi(
                                            data, context);
                                        print('api hit');
                                      }
                                    },
                                    text: context.watch<AuthViewModel>().loading
                                        ? 'Loading...'
                                        : 'Create Account',
                                    options: FFButtonOptions(
                                      width: 300,
                                      height: 50,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color: Colors.black,
                                      textStyle: GoogleFonts.getFont(
                                        'Open Sans',
                                        color: const Color(0xFFDEDEDE),
                                        fontSize: 16,
                                      ),
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.login);
                                  },
                                  child: Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: const Color(0xFF1F1F1F),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required bool obscureText,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.getFont(
              'Open Sans',
              color: const Color(0x7F455A64),
              fontWeight: FontWeight.normal,
            ),
            border: InputBorder.none,
            suffixIcon: suffixIcon,
          ),
          validator: validator,
        ),
      ),
    );
  }
}

class FFButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final FFButtonOptions options;

  const FFButtonWidget({
    required this.onPressed,
    required this.text,
    required this.options,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: options.color,
        padding: options.padding,
        shape: RoundedRectangleBorder(
          borderRadius: options.borderRadius,
        ),
        elevation: options.elevation.toDouble(),
      ),
      child: Text(
        text,
        style: options.textStyle,
      ),
    );
  }
}

class FFButtonOptions {
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final Color color;
  final TextStyle textStyle;
  final int elevation;
  final BorderRadius borderRadius;

  const FFButtonOptions({
    required this.width,
    required this.height,
    required this.padding,
    required this.color,
    required this.textStyle,
    required this.elevation,
    required this.borderRadius,
  });
}
