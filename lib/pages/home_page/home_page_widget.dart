import 'dart:convert';

import 'package:fitness_flow/model/user_model.dart';
import 'package:fitness_flow/services/fitness_flow_db.dart';
import 'package:flutter/widgets.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {

  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      reverse: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 2000.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(1.2, 1.2),
        ),
      ],
    ),
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        RotateEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 900.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation5': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 500.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 500.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation6': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 900.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 900.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };


  Future? futureUser;
  var futureUserSession;
  Future? futureKaloriHarian;
  Future? futureBeratBadan;
  Future? futureStepHarian;
  Future? futureLatihanHarian;
  final fitnessFlowDB = FitnessFlowDB();
  var hariini = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var beratuser = 0.0;

  void fetchUser() async {
    setState((){
      futureUser = fitnessFlowDB.fetchUserById(1);
    });
  }

  void fetchKaloriHarian(date) async {
    setState((){
      futureKaloriHarian = fitnessFlowDB.fetchKaloriHarian(date);
    });
  }

  void fetchStepHarian() async {
    setState((){
      futureStepHarian = fitnessFlowDB.fetchStepHarian(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    });
  }

  void fetchBeratBadan() async {
    setState((){
      futureBeratBadan = fitnessFlowDB.fetchBeratBadan();
    });
  }

  void fetchLatihanHarian(date) async {
    setState((){
      futureLatihanHarian = fitnessFlowDB.fetchLatihanHarianGroup(date);
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    fetchUser();
    fetchKaloriHarian(hariini);
    fetchBeratBadan();
    fetchStepHarian();
    fetchLatihanHarian(hariini);
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
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      FutureBuilder(
                        future: futureUser,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator(),);
                          } else {
                            futureUserSession = snapshot.data;
                            if (snapshot.data != null) {
                              beratuser = snapshot.data.berat_old;
                            }
                            return Stack(
                              alignment: AlignmentDirectional(-1.0, 1.0),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('ProfilePage');
                                    },
                                    child: Container(
                                      width: 48.0,
                                      height: 48.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: snapshot.data.foto != '' ? Image.memory(const Base64Decoder().convert(snapshot.data.foto!)).image : Image.network('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png').image,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF7EE4F0),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'containerOnPageLoadAnimation1']!),
                              ],
                            );
                          }
                          }
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                      FutureBuilder(
                        future: futureUser,
                        builder: (context, snapshot) {

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator(),);
                          } else {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/Sun.svg',
                                      width: 16.0,
                                      height: 16.0,
                                      fit: BoxFit.cover,
                                    ).animateOnPageLoad(
                                        animationsMap['imageOnPageLoadAnimation']!),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          6.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        dateTimeFormat(
                                            'MMMEd', getCurrentTimestamp),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              color: Color(0xFF8B80F8),
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 6.0, 0.0, 0.0),
                                  child: RichText(
                                    textScaler: MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Hi, ',
                                          style: TextStyle(),
                                        ),
                                        TextSpan(
                                          text: snapshot.data.username,
                                          style: TextStyle(),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Rubik',
                                            fontSize: 24.0,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: GridView(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 0.75,
                            ),
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                            FutureBuilder(
                              future: futureKaloriHarian,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator(),);
                                } else {
                                    var jumlahkalori = 0.0;
                                    var tanggalupdate = '';
                                    var kaloriuser = 0.0;
                                    var daily_calorie_intake = 0;
                                    var kaloriuserpersentase = 0.0;
                                    Object kaloriusertext = 0;
                                    if (snapshot.data != null && snapshot.data[0]['user_id'] != null) {
                                      jumlahkalori = (snapshot.data[0]['total_kalori_consumed']).toDouble();
                                      tanggalupdate = '';
                                      kaloriuser = snapshot.data[0]['total_kalori_consumed'].toDouble();
                                      daily_calorie_intake = hitungKaloriHarian(snapshot.data[0]);
                                      kaloriuserpersentase = kaloriuser / daily_calorie_intake;
                                      kaloriusertext = daily_calorie_intake != 0 ? (kaloriuserpersentase * 100).round().toString() : 0;
                                    }
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'CalorieTracker',
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
                                    child: Container(
                                      width: 156.0,
                                      height: 216.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF8B80F8),
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'KALORI',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Rubik',
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            letterSpacing: 1.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                ),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              percent: kaloriuserpersentase,
                                              radius: 48.0,
                                              lineWidth: 18.0,
                                              animation: true,
                                              animateFromLastPercent: true,
                                              progressColor: Color(0xFF7EE4F0),
                                              backgroundColor: Color(0x32000000),
                                              center: Text(
                                                '$kaloriusertext%',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Rubik',
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '$jumlahkalori',
                                                      style: FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Rubik',
                                                            color: Colors.white,
                                                            fontSize: 24.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              2.0, 0.0, 0.0, 2.0),
                                                      child: Text(
                                                        'cal',
                                                        style: FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              color: Colors.white,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'dari ${daily_calorie_intake}cal',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Rubik',
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.normal,
                                                          ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'containerOnPageLoadAnimation2']!);
                                  }
                                }
                              ),
                              FutureBuilder(
                                future: futureBeratBadan,
                                builder: (context, snap) {
                                  if (snap.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator(),);
                                  } else {
                                    var xarray = [1.0];
                                    var yarray = [beratuser.toDouble()];
                                    if (snap.data.length != 0) {
                                      for (var key = 1; key <= snap.data.length;key++) {
                                        var datafor = snap.data[key-1];
                                        xarray.add((key+1).toDouble());
                                        yarray.add(datafor['berat'].toDouble());
                                      }
                                    }
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'WeightTracker',
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
                                    child: Container(
                                      width: 156.0,
                                      height: 216.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFAF8EFF),
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'BERAT BADAN',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Rubik',
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            letterSpacing: 1.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 72.0,
                                              child: FlutterFlowLineChart(
                                                data: [
                                                  FFLineChartData(
                                                    xData: xarray,
                                                    yData: yarray,
                                                    settings: LineChartBarData(
                                                      color: Color(0xFF7165E3),
                                                      barWidth: 2.0,
                                                      isCurved: true,
                                                      dotData:
                                                          FlDotData(show: false),
                                                    ),
                                                  )
                                                ],
                                                chartStylingInfo: ChartStylingInfo(
                                                  backgroundColor:
                                                      Color(0x00FFFFFF),
                                                  showBorder: false,
                                                ),
                                                axisBounds: AxisBounds(),
                                                xAxisLabelInfo: AxisLabelInfo(),
                                                yAxisLabelInfo: AxisLabelInfo(),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '${futureUserSession.berat}',
                                                      style: FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Rubik',
                                                            color: Colors.white,
                                                            fontSize: 24.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              2.0, 0.0, 0.0, 2.0),
                                                      child: Text(
                                                        'kg',
                                                        style: FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              color: Colors.white,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'target ${futureUserSession.target_berat}kg',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Rubik',
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.normal,
                                                          ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'containerOnPageLoadAnimation3']!);
                                }
                                }
                              ),
                              FutureBuilder(
                                future: futureLatihanHarian,
                                builder: (context, snap) {
                                  if (snap.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator(),);
                                  } else {
                                    var total = snap.data[0]['belum_count'] + snap.data[0]['sudah_count'];
                                    print(total);
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'EventsPage',
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
                                      child: Container(
                                        width: 156.0,
                                        height: 216.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1E87FD),
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'LATIHAN',
                                                    style:
                                                        FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              color: Colors.white,
                                                              fontSize: 12.0,
                                                              letterSpacing: 1.0,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                  ),
                                                ],
                                              ),
                                              Image.asset(
                                                'assets/images/report.png',
                                                width: 84.0,
                                                height: 84.0,
                                                fit: BoxFit.contain,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        total == 0 ? 'Belum': "${snap.data[0]['sudah_count'].toString()}",
                                                        style: FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              color: Colors.white,
                                                              fontSize: 24.0,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                2.0, 0.0, 0.0, 2.0),
                                                        child: Text(
                                                          total == 0 ? '':'dari ${total}',
                                                          style: FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: 'Rubik',
                                                                color: Colors.white,
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight.normal,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    total == 0 ? 'memilih latihan' : 'sudah diselesaikan',
                                                    style:
                                                        FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                            ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation4']!);
                                  }
                                }
                              ),
                              
                              FutureBuilder(
                                future: futureStepHarian,
                                builder: (context, snap) {
                                  if (snap.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator(),);
                                  } else {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'StepsTracker',
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
                                      child: Container(
                                        width: 156.0,
                                        height: 216.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF4C5A81),
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'LANGKAH',
                                                    style:
                                                        FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              color: Colors.white,
                                                              fontSize: 12.0,
                                                              letterSpacing: 1.0,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                  ),
                                                ],
                                              ),
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional(0.0, 0.0),
                                                children: [
                                                  CircularPercentIndicator(
                                                    percent: 1.0,
                                                    radius: 48.0,
                                                    lineWidth: 12.0,
                                                    animation: true,
                                                    animateFromLastPercent: true,
                                                    progressColor: Color(0xFF7165E3),
                                                    backgroundColor:
                                                        Color(0x32000000),
                                                  ),
                                                  Icon(
                                                    Icons.directions_run_rounded,
                                                    color: Colors.white,
                                                    size: 36.0,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "${snap.data[0]['total_steps']}",
                                                        style: FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              color: Colors.white,
                                                              fontSize: 24.0,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Langkah hari ini',
                                                    style:
                                                        FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Rubik',
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                            ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation5']!);
                                  }
                                }
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(24.0),
                  //   child: Container(
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       color: Color(0xFFF5F6FA),
                  //       borderRadius: BorderRadius.circular(24.0),
                  //     ),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(24.0),
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.max,
                  //         children: [
                  //           Row(
                  //             mainAxisSize: MainAxisSize.max,
                  //             children: [
                  //               Stack(
                  //                 alignment: AlignmentDirectional(0.0, 0.0),
                  //                 children: [
                  //                   CircularPercentIndicator(
                  //                     percent: 0.85,
                  //                     radius: 30.0,
                  //                     lineWidth: 4.0,
                  //                     animation: true,
                  //                     animateFromLastPercent: true,
                  //                     progressColor: Color(0xFF7165E3),
                  //                     backgroundColor: Color(0xFFE9E9E9),
                  //                   ),
                  //                   SvgPicture.asset(
                  //                     'assets/images/spoon.svg',
                  //                     width: 24.0,
                  //                     height: 24.0,
                  //                     fit: BoxFit.contain,
                  //                   ),
                  //                 ],
                  //               ),
                  //               Expanded(
                  //                 child: Padding(
                  //                   padding: EdgeInsetsDirectional.fromSTEB(
                  //                       12.0, 0.0, 0.0, 0.0),
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.max,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       RichText(
                  //                         textScaler:
                  //                             MediaQuery.of(context).textScaler,
                  //                         text: TextSpan(
                  //                           children: [
                  //                             TextSpan(
                  //                               text: '2158',
                  //                               style: TextStyle(),
                  //                             ),
                  //                             TextSpan(
                  //                               text: ' of ',
                  //                               style: TextStyle(),
                  //                             ),
                  //                             TextSpan(
                  //                               text: '2850',
                  //                               style: TextStyle(),
                  //                             ),
                  //                             TextSpan(
                  //                               text: ' Cal',
                  //                               style: TextStyle(),
                  //                             )
                  //                           ],
                  //                           style: FlutterFlowTheme.of(context)
                  //                               .bodyMedium
                  //                               .override(
                  //                                 fontFamily: 'Rubik',
                  //                                 fontSize: 16.0,
                  //                               ),
                  //                         ),
                  //                       ),
                  //                       Padding(
                  //                         padding:
                  //                             EdgeInsetsDirectional.fromSTEB(
                  //                                 0.0, 6.0, 0.0, 0.0),
                  //                         child: Text(
                  //                           'Add more calories to your diet',
                  //                           style: FlutterFlowTheme.of(context)
                  //                               .bodyMedium
                  //                               .override(
                  //                                 fontFamily: 'Rubik',
                  //                                 color: Color(0xFF828282),
                  //                                 fontWeight: FontWeight.normal,
                  //                               ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               FlutterFlowIconButton(
                  //                 borderColor: Colors.transparent,
                  //                 borderRadius: 24.0,
                  //                 borderWidth: 1.0,
                  //                 buttonSize: 36.0,
                  //                 fillColor: Color(0xFFE4DFFF),
                  //                 icon: Icon(
                  //                   Icons.add_rounded,
                  //                   color: Color(0xFF7165E3),
                  //                   size: 16.0,
                  //                 ),
                  //                 onPressed: () async {
                  //                   context.pushNamed('FoodJournal');
                  //                 },
                  //               ),
                  //             ],
                  //           ),
                  //           Divider(
                  //             height: 48.0,
                  //             thickness: 1.0,
                  //             color: Color(0xFFE9E9E9),
                  //           ),
                  //           Column(
                  //             mainAxisSize: MainAxisSize.max,
                  //             children: [
                  //               Row(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Expanded(
                  //                     child: Padding(
                  //                       padding: EdgeInsetsDirectional.fromSTEB(
                  //                           0.0, 0.0, 12.0, 0.0),
                  //                       child: Column(
                  //                         mainAxisSize: MainAxisSize.min,
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           Text(
                  //                             'Proteins: 56%',
                  //                             style:
                  //                                 FlutterFlowTheme.of(context)
                  //                                     .bodyMedium
                  //                                     .override(
                  //                                       fontFamily: 'Rubik',
                  //                                       fontSize: 12.0,
                  //                                       fontWeight:
                  //                                           FontWeight.normal,
                  //                                     ),
                  //                           ),
                  //                           Padding(
                  //                             padding: EdgeInsetsDirectional
                  //                                 .fromSTEB(0.0, 6.0, 0.0, 0.0),
                  //                             child: LinearPercentIndicator(
                  //                               percent: 0.4,
                  //                               width: 132.0,
                  //                               lineHeight: 6.0,
                  //                               animation: true,
                  //                               animateFromLastPercent: true,
                  //                               progressColor:
                  //                                   Color(0xFFFF8C00),
                  //                               backgroundColor:
                  //                                   Color(0xFFE9E9E9),
                  //                               barRadius:
                  //                                   Radius.circular(12.0),
                  //                               padding: EdgeInsets.zero,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Expanded(
                  //                     child: Padding(
                  //                       padding: EdgeInsetsDirectional.fromSTEB(
                  //                           12.0, 0.0, 0.0, 0.0),
                  //                       child: Column(
                  //                         mainAxisSize: MainAxisSize.max,
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           Text(
                  //                             'Proteins: 142%',
                  //                             style:
                  //                                 FlutterFlowTheme.of(context)
                  //                                     .bodyMedium
                  //                                     .override(
                  //                                       fontFamily: 'Rubik',
                  //                                       fontSize: 12.0,
                  //                                       fontWeight:
                  //                                           FontWeight.normal,
                  //                                     ),
                  //                           ),
                  //                           Padding(
                  //                             padding: EdgeInsetsDirectional
                  //                                 .fromSTEB(0.0, 6.0, 0.0, 0.0),
                  //                             child: LinearPercentIndicator(
                  //                               percent: 1.0,
                  //                               width: 132.0,
                  //                               lineHeight: 6.0,
                  //                               animation: true,
                  //                               animateFromLastPercent: true,
                  //                               progressColor:
                  //                                   Color(0xFFDD2E44),
                  //                               backgroundColor:
                  //                                   Color(0xFFE9E9E9),
                  //                               barRadius:
                  //                                   Radius.circular(12.0),
                  //                               padding: EdgeInsets.zero,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               Padding(
                  //                 padding: EdgeInsetsDirectional.fromSTEB(
                  //                     0.0, 24.0, 0.0, 0.0),
                  //                 child: Row(
                  //                   mainAxisSize: MainAxisSize.max,
                  //                   children: [
                  //                     Expanded(
                  //                       child: Padding(
                  //                         padding:
                  //                             EdgeInsetsDirectional.fromSTEB(
                  //                                 0.0, 0.0, 12.0, 0.0),
                  //                         child: Column(
                  //                           mainAxisSize: MainAxisSize.max,
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(
                  //                               'Proteins: 90%',
                  //                               style:
                  //                                   FlutterFlowTheme.of(context)
                  //                                       .bodyMedium
                  //                                       .override(
                  //                                         fontFamily: 'Rubik',
                  //                                         fontSize: 12.0,
                  //                                         fontWeight:
                  //                                             FontWeight.normal,
                  //                                       ),
                  //                             ),
                  //                             Padding(
                  //                               padding: EdgeInsetsDirectional
                  //                                   .fromSTEB(
                  //                                       0.0, 6.0, 0.0, 0.0),
                  //                               child: LinearPercentIndicator(
                  //                                 percent: 0.9,
                  //                                 width: 132.0,
                  //                                 lineHeight: 6.0,
                  //                                 animation: true,
                  //                                 animateFromLastPercent: true,
                  //                                 progressColor:
                  //                                     Color(0xFF7ABD4C),
                  //                                 backgroundColor:
                  //                                     Color(0xFFE9E9E9),
                  //                                 barRadius:
                  //                                     Radius.circular(12.0),
                  //                                 padding: EdgeInsets.zero,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Expanded(
                  //                       child: Padding(
                  //                         padding:
                  //                             EdgeInsetsDirectional.fromSTEB(
                  //                                 12.0, 0.0, 0.0, 0.0),
                  //                         child: Column(
                  //                           mainAxisSize: MainAxisSize.max,
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(
                  //                               'Proteins: 86%',
                  //                               style:
                  //                                   FlutterFlowTheme.of(context)
                  //                                       .bodyMedium
                  //                                       .override(
                  //                                         fontFamily: 'Rubik',
                  //                                         fontSize: 12.0,
                  //                                         fontWeight:
                  //                                             FontWeight.normal,
                  //                                       ),
                  //                             ),
                  //                             Padding(
                  //                               padding: EdgeInsetsDirectional
                  //                                   .fromSTEB(
                  //                                       0.0, 6.0, 0.0, 0.0),
                  //                               child: LinearPercentIndicator(
                  //                                 percent: 0.8,
                  //                                 width: 132.0,
                  //                                 lineHeight: 6.0,
                  //                                 animation: true,
                  //                                 animateFromLastPercent: true,
                  //                                 progressColor:
                  //                                     Color(0xFFFFC850),
                  //                                 backgroundColor:
                  //                                     Color(0xFFE9E9E9),
                  //                                 barRadius:
                  //                                     Radius.circular(12.0),
                  //                                 padding: EdgeInsets.zero,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ).animateOnPageLoad(
                  //       animationsMap['containerOnPageLoadAnimation6']!),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
