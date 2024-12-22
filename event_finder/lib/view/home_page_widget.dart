// ignore_for_file: unused_import, unnecessary_import, prefer_typing_uninitialized_variables, constant_identifier_names

import 'dart:core';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../view_model/home_page_model.dart';
export '../view_model/home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel(); // Inisialisasi benar

    // Inisialisasi textController dan textFieldFocusNode jika null
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
      backgroundColor: FlutterFlowTheme.of(context).secondary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Image.asset(
                    'assets/images/home_image.png',
                    width: double.infinity,
                    height: 255,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 60, 20, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 17),
                          child: Image.asset(
                            'res/assets/images/logo.png',
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Your place for searching ART.',
                          style: FlutterFlowTheme
                              .bodyMedium
                              .copyWith(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context).secondary,
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 27, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'SearchResultsPage',
                                        queryParameters: {
                                          'searchTerm': serializeParam(
                                            _model.textController!.text,
                                            ParamType.String as ParamType,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Icon(
                                      Icons.search,
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      size: 24,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 0, 2),
                                      child: TextFormField(
                                        controller: _model.textController,
                                        focusNode: _model.textFieldFocusNode,
                                        onFieldSubmitted: (_) async {
                                          context.pushNamed(
                                            'SearchResultsPage',
                                            queryParameters: {
                                              'searchTerm': serializeParam(
                                                _model.textController!.text,
                                                ParamType.String as ParamType,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          hintText:
                                              'Search artist, maker, department...',
                                          enabledBorder: UnderlineInputBorder(
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
                                          focusedBorder: UnderlineInputBorder(
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
                                          errorBorder: UnderlineInputBorder(
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
                                              UnderlineInputBorder(
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
                                        style: FlutterFlowTheme
                                            .bodyMedium
                                            .copyWith(
                                              fontFamily: 'Inter',
                                              fontSize: 16,
                                              letterSpacing: 0.0,
                                            ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Field ini tidak boleh kosong';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(-1.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(10, 15, 0, 20),
                            child: Text(
                              'Museum Departments',
                              style: FlutterFlowTheme.bodyMedium.copyWith(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        FutureBuilder<ApiCallResponse>(
                          future: GetDepartmentsCall.call(),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final gridViewGetDepartmentsResponse =
                                snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final departments = getJsonField(
                                  gridViewGetDepartmentsResponse.jsonBody,
                                  r'''$.departments''',
                                ).toList().take(30).toList();

                                return GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1.6,
                                  ),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: departments.length,
                                  itemBuilder: (context, departmentsIndex) {
                                    final departmentsItem =
                                        departments[departmentsIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'DepartmentHighlightsPage',
                                          queryParameters: {
                                            'departmentId': serializeParam(
                                              getJsonField(
                                                departmentsItem,
                                                r'''$.departmentId''',
                                              ),
                                              ParamType.int as ParamType,
                                            ),
                                            'displayName': serializeParam(
                                              getJsonField(
                                                departmentsItem,
                                                r'''$.displayName''',
                                              ).toString(),
                                              ParamType.String as ParamType,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Colors.white,
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Align(
                                          alignment: const AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 5, 0),
                                            child: Text(
                                              getJsonField(
                                                departmentsItem,
                                                r'''$.displayName''',
                                              ).toString(),
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme
                                                      .displaySmall
                                                      .copyWith(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  serializeParam(String text, ParamType type) {
    return text;
  }

  getJsonField(dynamic json, String field) {
    // Replace this with actual JSON parsing logic
    return json[field] ?? [];
  }
}

class HomePageModel {
  TextEditingController? textController;
  FocusNode? textFieldFocusNode;

  HomePageModel() {
    textController = TextEditingController();
    textFieldFocusNode = FocusNode();
  }

  void dispose() {
    textController?.dispose();
    textFieldFocusNode?.dispose();
  }
}

class GetDepartmentsCall {
  static Future<ApiCallResponse> call() async {
    return ApiCallResponse();
  }
}

class ApiCallResponse {
  dynamic get jsonBody => {};
}

extension ContextExtensions on BuildContext {
  void pushNamed(String routeName, {required Map<String, dynamic> queryParameters}) {}
}

extension MapExtensions on Map<String, dynamic> {
  Map<String, dynamic> get withoutNulls => this;
}

class ParamType {
  static const String = 'String';
  static const int = 'int';

  static var JSON;
}
