import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fitness_flow/services/fitness_flow_db.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'food_nutrients_model.dart';
export 'food_nutrients_model.dart';

class FoodNutrientsWidget extends StatefulWidget {
  const FoodNutrientsWidget({
    super.key,
    required this.id,
  });

  final int? id;

  @override
  State<FoodNutrientsWidget> createState() => _FoodNutrientsWidgetState();
}

class _FoodNutrientsWidgetState extends State<FoodNutrientsWidget> {
  late FoodNutrientsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FoodNutrientsModel());
    fetchMeals(widget.id);
  }


  Future? futureMeal;
  var breakfastCheckbox = true;
  var lunchCheckbox = false;
  var dinnerCheckbox = false;
  final fitnessFlowDB = FitnessFlowDB();
  void fetchMeals(id) async {
    setState((){
      futureMeal = fitnessFlowDB.fetchMealById(id);
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: FutureBuilder(
            future: futureMeal,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(),);
              } else {
            var itemData = snapshot.data[0];
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              itemData['gambar'],
                            ).image,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 36.0, 24.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 12.0,
                                    borderWidth: 1.0,
                                    buttonSize: 48.0,
                                    fillColor: Color(0x00FFFFFF),
                                    icon: Icon(
                                      Icons.keyboard_arrow_left,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      context.pushNamed(
                                        'FormAddMeal',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.scale,
                                            alignment: Alignment.bottomCenter,
                                            duration: Duration(milliseconds: 200),
                                          ),
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -0.45),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0.0, 240.0, 0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primaryBackground,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(36.0),
                                topRight: Radius.circular(36.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 24.0, 24.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              itemData['type'],
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color:
                                                        FlutterFlowTheme.of(context)
                                                            .primary,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.4,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      0.0, 12.0, 0.0, 0.0),
                                              child: Text(
                                                itemData['nama'],
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      0.0, 8.0, 24.0, 0.0),
                                              child: Text(
                                                itemData['deskripsi'],
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Rubik',
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 24.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Nutrition Fact',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              12.0, 36.0, 12.0, 0.0),
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 24.0,
                                                        height: 24.0,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF0066FF),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8.0),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Berat',
                                                        style: FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                            ),
                                                      ),
                                                      Text(
                                                        "${itemData['berat']}g",
                                                        style: FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    height: 24.0,
                                                    thickness: 1.0,
                                                    color: Color(0xFFE9E9E9),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 24.0,
                                                        height: 24.0,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF8B80F8),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8.0),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Kalori',
                                                        style: FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                            ),
                                                      ),
                                                      Text(
                                                        "${itemData['kalori']}",
                                                        style: FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    height: 24.0,
                                                    thickness: 1.0,
                                                    color: Color(0xFFE9E9E9),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 24.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        CheckboxListTile(
                                            title: const Text('Breakfast'),
                                            value: breakfastCheckbox,
                                            onChanged: (bool? value) {
                                            setState(() {
                                                breakfastCheckbox = value!;
                                                if (value){
                                                    lunchCheckbox = dinnerCheckbox  = false;
                                                }
                                            });
                                            },
                                        ),
                                        CheckboxListTile(
                                            title: const Text('Lunch'),
                                            value: lunchCheckbox,
                                            onChanged: (bool? value) {
                                            setState(() {
                                                lunchCheckbox = value!;
                                                if (value){
                                                    breakfastCheckbox = dinnerCheckbox = false;
                                                }
                                            });
                                            },
                                        ),
                                        CheckboxListTile(
                                            title: const Text('Dinner'),
                                            value: dinnerCheckbox,
                                            onChanged: (bool? value) {
                                            setState(() {
                                                dinnerCheckbox = value!;
                                                if (value){
                                                    breakfastCheckbox = lunchCheckbox = false;
                                                }
                                            });
                                            },
                                        ),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                var minat = 'Breakfast';
                                if (breakfastCheckbox) {
                                  minat = 'Breakfast';
                                } else if (lunchCheckbox) {
                                  minat = 'Lunch';
                                } else {
                                  minat = 'Dinner';
                                }
                                fitnessFlowDB.createKaloriUser(1, itemData['berat'], itemData['kalori'], minat, itemData['id']);

                                final snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Berhasil!',
                                    message:
                                        'Kalori harian berhasil ditambahkan',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.success,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                                context.pushNamed('FoodJournal');
                              },
                              text: 'Add to Journal',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 54.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Rubik',
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 2.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
              }
          }
        ),
      ),
    );
  }
}
