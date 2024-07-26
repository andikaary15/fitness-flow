import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fitness_flow/services/fitness_flow_db.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'weight_tracker_model.dart';
export 'weight_tracker_model.dart';

class WeightTrackerWidget extends StatefulWidget {
  const WeightTrackerWidget({super.key});

  @override
  State<WeightTrackerWidget> createState() => _WeightTrackerWidgetState();
}

class _WeightTrackerWidgetState extends State<WeightTrackerWidget>
    with TickerProviderStateMixin {
  late WeightTrackerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
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
          begin: Offset(0.0, 5.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
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
          begin: Offset(0.0, 10.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
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
          begin: Offset(0.0, 10.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  Future? futureUser;
  var futureUserSession;
  Future? futureBeratBadan;
  final fitnessFlowDB = FitnessFlowDB();
  var hariini = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var beratuser = 0.0;

  void fetchUser() async {
    setState((){
      futureUser = fitnessFlowDB.fetchUserById(1);
    });
  }

  void fetchBeratBadan() async {
    setState((){
      futureBeratBadan = fitnessFlowDB.fetchBeratBadan();
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeightTrackerModel());
    fetchUser();
    fetchBeratBadan();
  }


  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  deleteBeratBadan(id) async {
    var user = await fitnessFlowDB.fetchUserByIdV2(1);
    setState(()  {
      fitnessFlowDB.deleteBeratBadan(id);
      fitnessFlowDB.updateUser(1, 'berat', user[0]['berat_old'].toString());
      fetchBeratBadan();
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed('Subscription');
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: Icon(
            Icons.add_outlined,
            color: Colors.white,
            size: 24.0,
          ),
        ),
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
                    buttonSize: 48.0,
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      context.pushNamed('HomePage');
                    },
                  ),
                  Text(
                    'Berat Badan',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Rubik',
                          color: Colors.white,
                          fontSize: 16.0,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 48.0,
                    icon: Icon(
                      Icons.more_vert_outlined,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: futureUser,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(),);
                } else {
                  if (snapshot.data != null) {
                  beratuser = snapshot.data.berat_old;
                  }
                  var persentase = snapshot.data.berat / int.parse(snapshot.data.target_berat);
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(48.0, 48.0, 48.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SEKARANG',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Rubik',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    letterSpacing: 0.6,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${snapshot.data.berat}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Rubik',
                                        color: Colors.white,
                                        fontSize: 36.0,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 0.0, 0.0, 6.0),
                                  child: Text(
                                    'kg',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          color: Colors.white,
                                          letterSpacing: 0.2,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            CircularPercentIndicator(
                              percent: persentase.clamp(0.0, 1.0),
                              radius: 30.0,
                              lineWidth: 4.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor:
                                  FlutterFlowTheme.of(context).primaryBackground,
                              backgroundColor: Color(0x4D000000),
                            ),
                            SvgPicture.asset(
                              'assets/images/weight-scale.svg',
                              width: 24.0,
                              height: 24.0,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TARGET',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Rubik',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    letterSpacing: 0.6,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${snapshot.data.target_berat}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Rubik',
                                        color: Colors.white,
                                        fontSize: 36.0,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 0.0, 0.0, 6.0),
                                  child: Text(
                                    'kg',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          color: Colors.white,
                                          letterSpacing: 0.2,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(36.0),
                      topRight: Radius.circular(36.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: 
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
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 24.0, 24.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Prosesku',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          fontSize: 16.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 0.0, 0.0),
                                      child: Container(
                                        width: 300.0,
                                        height: 120.0,
                                        child: FlutterFlowLineChart(
                                          data: [
                                            FFLineChartData(
                                              xData: xarray,
                                              yData: yarray,
                                              settings: LineChartBarData(
                                                color: FlutterFlowTheme.of(context)
                                                    .primary,
                                                barWidth: 2.0,
                                                isCurved: true,
                                                dotData: FlDotData(show: false),
                                              ),
                                            )
                                          ],
                                          chartStylingInfo: ChartStylingInfo(
                                            backgroundColor: Color(0x00FFFFFF),
                                            showGrid: true,
                                            showBorder: false,
                                          ),
                                          axisBounds: AxisBounds(),
                                          xAxisLabelInfo: AxisLabelInfo(),
                                          yAxisLabelInfo: AxisLabelInfo(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 36.0, 24.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Timeline',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          fontSize: 16.0,
                                        ),
                                  ),
                                  Icon(
                                    Icons.keyboard_control_outlined,
                                    color: Color(0xFFE9E9E9),
                                    size: 24.0,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 48.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 16.0,
                                                  height: 16.0,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        FlutterFlowTheme.of(context)
                                                            .primary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                ClipRRect(
                                                  child: Container(
                                                    width: 2.0,
                                                    height: 96.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .tertiary,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 16.0,
                                                  height: 16.0,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        FlutterFlowTheme.of(context)
                                                            .primary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                ClipRRect(
                                                  child: Container(
                                                    width: 2.0,
                                                    height: 96.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .tertiary,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: 16.0,
                                                  height: 16.0,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        FlutterFlowTheme.of(context)
                                                            .primary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              FutureBuilder(
                                                future: futureBeratBadan,
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  } else {
                                                    if (snapshot.data.length == 0) {
                                                      return Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text('Tidak ada data')
                                                        ],
                                                      );
                                                    } else {
                                                      return ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: snapshot.data.length,
                                                        itemBuilder: (BuildContext context, int index) { 
                                                          var itemData = snapshot.data[index];
                                                          return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                      0.0, 16.0, 0.0, 0.0),
                                                              child: Container(
                                                                width: 286.6,
                                                                height: 100.0,
                                                                decoration: BoxDecoration(
                                                                  color:
                                                                      FlutterFlowTheme.of(context)
                                                                          .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius.circular(24.0),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0, 12.0, 24.0, 12.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize.min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment
                                                                                    .end,
                                                                            children: [
                                                                              Text(
                                                                                "${itemData['berat']}",
                                                                                style: FlutterFlowTheme
                                                                                        .of(context)
                                                                                    .bodyMedium
                                                                                    .override(
                                                                                      fontFamily:
                                                                                          'Rubik',
                                                                                      color: FlutterFlowTheme.of(
                                                                                              context)
                                                                                          .secondary,
                                                                                      fontSize:
                                                                                          24.0,
                                                                                    ),
                                                                              ),
                                                                              Padding(
                                                                                padding:
                                                                                    EdgeInsetsDirectional
                                                                                        .fromSTEB(
                                                                                            2.0,
                                                                                            0.0,
                                                                                            0.0,
                                                                                            2.0),
                                                                                child: Text(
                                                                                  'kg',
                                                                                  style: FlutterFlowTheme.of(
                                                                                          context)
                                                                                      .bodyMedium
                                                                                      .override(
                                                                                        fontFamily:
                                                                                            'Rubik',
                                                                                        color: FlutterFlowTheme.of(
                                                                                                context)
                                                                                            .secondary,
                                                                                        fontSize:
                                                                                            12.0,
                                                                                        letterSpacing:
                                                                                            0.2,
                                                                                        fontWeight:
                                                                                            FontWeight
                                                                                                .normal,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                            '24 Feb 2023',
                                                                            style: FlutterFlowTheme
                                                                                    .of(context)
                                                                                .bodyMedium
                                                                                .override(
                                                                                  fontFamily:
                                                                                      'Rubik',
                                                                                  color: Color(
                                                                                      0xFF7165E3),
                                                                                  fontSize: 12.0,
                                                                                  fontWeight:
                                                                                      FontWeight
                                                                                          .normal,
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        width: 60.0,
                                                                        height: 60.0,
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          image: DecorationImage(
                                                                            fit: BoxFit.cover,
                                                                            image: Image.memory(
                                                                              const Base64Decoder().convert(itemData['foto']!),
                                                                            ).image,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius
                                                                                  .circular(12.0),
                                                                          border: Border.all(
                                                                            color: Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),FlutterFlowIconButton(
                                                                    borderColor: Colors.transparent,
                                                                    borderRadius: 12.0,
                                                                    borderWidth: 1.0,
                                                                    buttonSize: 36.0,
                                                                    fillColor: Colors.transparent,
                                                                    icon: FaIcon(
                                                                      FontAwesomeIcons.trashAlt,
                                                                      color: Colors.red,
                                                                      size: 16.0,
                                                                    ),
                                                                    onPressed: () {
                                                                      deleteBeratBadan(itemData['id']);
                                                                      final snackBar = SnackBar(
                                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                                        elevation: 0,
                                                                        behavior: SnackBarBehavior.floating,
                                                                        backgroundColor: Colors.transparent,
                                                                        content: AwesomeSnackbarContent(
                                                                          title: 'Berhasil!',
                                                                          message:
                                                                              'Berat berhasil dihapus',

                                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                          contentType: ContentType.success,
                                                                        ),
                                                                      );

                                                                      ScaffoldMessenger.of(context)
                                                                        ..hideCurrentSnackBar()
                                                                        ..showSnackBar(snackBar);
                                                                    },
                                                                  ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ).animateOnPageLoad(animationsMap[
                                                                  'containerOnPageLoadAnimation3']!),
                                                            );
                                                        },
                                                      );
                                                    }
                                                  }
                                              }
                                            ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      }
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
