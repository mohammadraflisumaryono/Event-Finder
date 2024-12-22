// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, unused_import, unnecessary_import, deprecated_member_use

import 'dart:io';

import '/auth/custom_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../view_model/login_page_model.dart';
export '../view_model/login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  get authManager => null;
  
  bool get isAndroid => Platform.isAndroid; 

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.emailTextController ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
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
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Image.asset(
                                'assets/images/logo_flutterMet@2x.png',
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
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
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 20, 0),
                                      child: TextFormField(
                                        controller: _model.emailTextController,
                                        focusNode: _model.textFieldFocusNode1,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          hintStyle: GoogleFonts.getFont(
                                            'Open Sans',
                                            color: const Color(0x7F455A64),
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.only(
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
                                            borderRadius:
                                                BorderRadius.only(
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Field cannot be empty';
                                            }
                                            return null;
                                            },
                                      ),
                                    ),
                                  ),
                                ),
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
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 20, 0),
                                      child: TextFormField(
                                        controller:
                                            _model.passwordTextController,
                                        focusNode: _model.textFieldFocusNode2,
                                        obscureText: !_model.passwordVisibility,
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: GoogleFonts.getFont(
                                            'Open Sans',
                                            color: const Color(0x7F455A64),
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.only(
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
                                            borderRadius:
                                                BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () => safeSetState(
                                              () => _model.passwordVisibility =
                                                  !_model.passwordVisibility,
                                            ),
                                            focusNode:
                                                FocusNode(skipTraversal: true),
                                            child: Icon(
                                              _model.passwordVisibility
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Field cannot be empty';
                                            }
                                            return null;
                                            },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 18),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      GoRouter.of(context).prepareAuthEvent();
                                      await authManager.signIn();

                                      context.goNamedAuth(
                                          'HomePage', context.mounted);
                                    },
                                    text: 'Sign in with email',
                                    options: FFButtonOptions(
                                      width: 300,
                                      height: 50,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color: Colors.black,
                                      textStyle: GoogleFonts.getFont(
                                        'Open Sans',
                                        color: const Color(0xFFDEDEDE),
                                        fontSize: 16,
                                      ),
                                      elevation: 2,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ), icon: const FaIcon(FontAwesomeIcons.user),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.goNamed('CreateAccountPage');
                                    },
                                    child: Text(
                                      'Create Account',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: const Color(0xFF1F1F1F),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  GoRouter.of(context).prepareAuthEvent();
                                  await authManager.signIn();

                                  context.goNamedAuth(
                                      'HomePage', context.mounted);
                                },
                                text: 'Continue as Guest',
                                icon: const FaIcon(
                                  FontAwesomeIcons.home,
                                  color: Color(0xFF4B39EF),
                                  size: 20,
                                ),
                                options: FFButtonOptions(
                                  width: 200,
                                  height: 44,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      3, 0, 10, 1),
                                  color: Colors.white,
                                  textStyle: GoogleFonts.getFont(
                                    'Roboto',
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  elevation: 4,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                                child: SizedBox(
                                  width: 200,
                                  height: 44,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: const AlignmentDirectional(0, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            GoRouter.of(context)
                                                .prepareAuthEvent();
                                            await authManager.signIn();

                                            context.goNamedAuth(
                                                'HomePage', context.mounted);
                                          },
                                          text: 'Sign in with Google',
                                          icon: const FaIcon(
                                            FontAwesomeIcons.plus, // Ganti dengan ikon FontAwesome yang sesuai
                                            color: Colors.transparent,
                                            size: 20,
                                            ),
                                          options: FFButtonOptions(
                                            width: 200,
                                            height: 44,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                            color: Colors.white,
                                            textStyle: GoogleFonts.getFont(
                                              'Roboto',
                                              color: const Color(0xFF606060),
                                              fontSize: 15,
                                            ),
                                            elevation: 4,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-0.83, 0),
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            'https://i0.wp.com/nanophorm.com/wp-content/uploads/2018/04/google-logo-icon-PNG-Transparent-Background.png?w=1000&ssl=1',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            isAndroid
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 15),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        GoRouter.of(context).prepareAuthEvent();
                                        await authManager.signIn();

                                        context.goNamedAuth(
                                            'HomePage', context.mounted);
                                      },
                                      text: 'Sign in with Apple',
                                      icon: const FaIcon(
                                        FontAwesomeIcons.apple,
                                        size: 20,
                                      ),
                                      options: FFButtonOptions(
                                        width: 200,
                                        height: 44,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 10, 1),
                                        color: Colors.white,
                                        textStyle: GoogleFonts.getFont(
                                          'Roboto',
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                        elevation: 4,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: SizedBox(
                                width: 200,
                                height: 44,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0, 0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          GoRouter.of(context)
                                              .prepareAuthEvent();
                                          await authManager.signIn();

                                          context.goNamedAuth(
                                              'HomePage', context.mounted);
                                        },
                                        text: 'Login with Facebook',
                                        icon: const FaIcon(
                                          FontAwesomeIcons.plus, // Pilih ikon yang sesuai dari FontAwesome
                                          color: Colors.transparent,
                                          size: 20,
                                          ),
                                        options: FFButtonOptions(
                                          width: 200,
                                          height: 44,
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          iconPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8, 0),
                                          color: Colors.white,
                                          textStyle: GoogleFonts.getFont(
                                            'Roboto',
                                            color: const Color(0xFF1877F2),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                          elevation: 4,
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(-0.83, 0),
                                      child: Container(
                                        width: 22,
                                        height: 22,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          'https://facebookbrand.com/wp-content/uploads/2019/04/f_logo_RGB-Hex-Blue_512.png?w=512&h=512',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
  
  LoginPageModel createModel(BuildContext context, LoginPageModel Function() param1) {
  return param1();
}

Widget safeSetState(bool Function() param0) {
  if (param0()) {
    return const SizedBox(); // Gantikan dengan widget yang sesuai
  }
  return Container(); // Atau widget lainnya
}
  
  FFButtonOptions({required int width, required int height, required EdgeInsetsDirectional padding, required EdgeInsetsDirectional iconPadding, required Color color, required TextStyle textStyle, required int elevation, required BorderSide borderSide, required BorderRadius borderRadius}) {}
  
  FFButtonWidget({required Future<Null> Function() onPressed, required String text, required options, required FaIcon icon}) {}
}

class GoRouter {
  static of(BuildContext context) {}
}

extension on BuildContext {
  void goNamedAuth(String s, bool mounted) {}
  
  void goNamed(String s) {}
}
