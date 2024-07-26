import 'package:fitness_flow/services/fitness_flow_db.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'calorie_tracker_model.dart';
export 'calorie_tracker_model.dart';

class CalorieTrackerWidget extends StatefulWidget {
  const CalorieTrackerWidget({super.key});

  @override
  State<CalorieTrackerWidget> createState() => _CalorieTrackerWidgetState();
}

class _CalorieTrackerWidgetState extends State<CalorieTrackerWidget>
    with TickerProviderStateMixin {
  late CalorieTrackerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'columnOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 20.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: Offset(0.0, 20.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: Offset(0.0, 20.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  var hariini = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalorieTrackerModel());
    fetchKaloriHarianGroup(hariini);

  }

  Future? futureUser;
  var futureUserSession;
  Future? futureKaloriHarianGroup;
  final fitnessFlowDB = FitnessFlowDB();

  void fetchUser() async {
    setState((){
      futureUser = fitnessFlowDB.fetchUserById(1);
    });
  }

  void fetchKaloriHarianGroup(date) async {
    setState((){
      futureKaloriHarianGroup = fitnessFlowDB.fetchKaloriHarianGroup(date);
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  hitungKaloriHarian(user) {
    var berat = user['type_berat'] == 'kg' ? user['berat'] : user['berat'] * 0.45359237;
    var bmr;
    if (user['jeniskelamin'] == 'L') {
      bmr = 66 + (13.7 * berat) + (5 * user['tinggi']) - (6.8 * int.parse(user['umur']));
    } else {
      bmr = 655 + (9.6 * berat) + (1.8 * user['tinggi']) - (4.7 * int.parse(user['umur']));
    }
    var kalori = bmr * user['aktivitas'];
    return kalori.round();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureKaloriHarianGroup,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
            var totalkalori = 0.0;
            var targetkalori = 0;

            var breakfast = 0.0;
            var lunch = 0.0;
            var dinner = 0.0;
            var totalkaloriharian = '0';
          if (snapshot.data != null && snapshot.data[0]['user_id'] != null) {
            totalkalori = (snapshot.data[0]['breakfast'] + snapshot.data[0]['lunch'] + snapshot.data[0]['dinner'].toDouble());
            targetkalori = hitungKaloriHarian(snapshot.data[0]);

            breakfast = snapshot.data[0]['breakfast'] / totalkalori;
            lunch = snapshot.data[0]['lunch'] / totalkalori;
            dinner = snapshot.data[0]['dinner'] / totalkalori;
            totalkaloriharian = ((totalkalori/targetkalori) * 100).round().toString();
          }



        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 48.0, 24.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        borderWidth: 1.0,
                        buttonSize: 60.0,
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          context.pushNamed('HomePage');
                        },
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed('FoodJournal');
                        },
                        text: 'Jurnal',
                        options: FFButtonOptions(
                          width: 84.0,
                          height: 40.0,
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFFE4DFFF),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Rubik',
                                    color: Color(0xFF7165E3),
                                    fontSize: 2.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 48.0, 24.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'ASUPAN HARIAN',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Rubik',
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 14.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(60.0, 12.0, 60.0, 0.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hari ini Anda telah mengkonsumsi ',
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: "$totalkalori cal",
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                              )
                            ],
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Rubik',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            CircularPercentIndicator(
                              percent: breakfast,
                              radius: 108.0,
                              lineWidth: 12.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor: Color(0xFF1D87FD),
                              backgroundColor: Color(0xFFE9E9E9),
                              startAngle: 0.0,
                            ),
                            CircularPercentIndicator(
                              percent: lunch,
                              radius: 87.0,
                              lineWidth: 12.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor: FlutterFlowTheme.of(context).primary,
                              backgroundColor: Color(0xFFE9E9E9),
                              startAngle: 0.0,
                            ),
                            CircularPercentIndicator(
                              percent: dinner,
                              radius: 66.0,
                              lineWidth: 12.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor: Color(0xFF7EE4F0),
                              backgroundColor: Color(0xFFE9E9E9),
                              startAngle: 0.0,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: Text(
                                    '${totalkaloriharian}%',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          fontSize: 24.0,
                                        ),
                                  ),
                                ),
                                Text(
                                  'dari tujuan harian',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Rubik',
                                        color: Color(0xFF828282),
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(36.0, 0.0, 36.0, 0.0),
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF0066FF),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      Text(
                                        'Breakfast',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                      Text(
                                        "${snapshot.data[0]['breakfast']}cal",
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.normal,
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
                              ).animateOnPageLoad(
                                  animationsMap['columnOnPageLoadAnimation1']!),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF8B80F8),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      Text(
                                        'Lunch',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                      Text(
                                        "${snapshot.data[0]['lunch']}cal",
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.normal,
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
                              ).animateOnPageLoad(
                                  animationsMap['columnOnPageLoadAnimation2']!),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF7EE4F0),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      Text(
                                        'Dinner',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                      Text(
                                        "${snapshot.data[0]['dinner']}cal",
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ).animateOnPageLoad(
                                  animationsMap['columnOnPageLoadAnimation3']!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(72.0, 0.0, 72.0, 60.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed('FormAddMeal');
                    },
                    text: 'Add Meal',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 54.0,
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
              ],
            ),
          ),
        );
        }
      }
    );
  }
}
