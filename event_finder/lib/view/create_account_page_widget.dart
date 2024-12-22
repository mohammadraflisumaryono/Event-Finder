// ignore_for_file: unused_import, unnecessary_import, use_build_context_synchronously, non_constant_identifier_names

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountPageWidget extends StatefulWidget {
  const CreateAccountPageWidget({super.key});

  @override
  State<CreateAccountPageWidget> createState() =>
      _CreateAccountPageWidgetState();
}

class _CreateAccountPageWidgetState extends State<CreateAccountPageWidget> {
  late CreateAccountPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = CreateAccountPageModel();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                  child: _buildTextField(
                                    controller: _model.emailTextController,
                                    focusNode: _model.textFieldFocusNode1,
                                    hintText: 'Email',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Field cannot be empty';
                                      } else if (!RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                          .hasMatch(value)) {
                                        return 'Enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                // Password TextField
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 4, 20),
                                  child: _buildTextField(
                                    controller: _model.passwordTextController,
                                    focusNode: _model.textFieldFocusNode2,
                                    hintText: 'Password',
                                    obscureText: !_model.passwordVisibility,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Field cannot be empty';
                                      }
                                      return null;
                                    },
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => _model.passwordVisibility =
                                            !_model.passwordVisibility,
                                      ),
                                      child: Icon(
                                        _model.passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        size: 22,
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
                                      // Simulate authentication logic
                                      final authSuccess = await Future.delayed(
                                          const Duration(seconds: 1),
                                          () => true);

                                      if (authSuccess && context.mounted) {
                                        context.goNamed('HomePage');
                                      }
                                    },
                                    text: 'Create Account',
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
                                    debugPrint('Navigating to LoginPage');
                                    context.goNamed('LoginPage');
                                  },
                                  child: const Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF1F1F1F),
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

class CreateAccountPageModel {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final FocusNode textFieldFocusNode1 = FocusNode();
  final FocusNode textFieldFocusNode2 = FocusNode();
  bool passwordVisibility = false;

  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();
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
