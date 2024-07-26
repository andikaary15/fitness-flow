import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fitness_flow/services/fitness_flow_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'steps_tracker_model.dart';
export 'steps_tracker_model.dart';
import 'package:pedometer/pedometer.dart';

class StepsTrackerWidget extends StatefulWidget {
  const StepsTrackerWidget({super.key});

  @override
  State<StepsTrackerWidget> createState() => _StepsTrackerWidgetState();
}

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class _StepsTrackerWidgetState extends State<StepsTrackerWidget> {
  late StepsTrackerModel _model;

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '', _steps = 'Mulai';
  var step_temp = 0;
  bool startcount = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StepsTrackerModel());
    initPlatformState();
    fetchStepHarian();
  }
  final fitnessFlowDB = FitnessFlowDB();

  Future? futureStepHarian;
  void fetchStepHarian() async {
    setState((){
      futureStepHarian = fitnessFlowDB.fetchStepHarian(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    });
  }

  void onStepCount(StepCount event) {
    setState(() {
      if (startcount) {
        step_temp++;
        _steps = step_temp.toString();
      }
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = '';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Cek Permision';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Pedometer Example'),
  //       ),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Text(
  //               'Steps Taken',
  //               style: TextStyle(fontSize: 30),
  //             ),
  //             Text(
  //               _steps,
  //               style: TextStyle(fontSize: 60),
  //             ),
  //             Divider(
  //               height: 100,
  //               thickness: 0,
  //               color: Colors.white,
  //             ),
  //             Text(
  //               'Pedestrian Status',
  //               style: TextStyle(fontSize: 30),
  //             ),
  //             Icon(
  //               _status == 'walking'
  //                   ? Icons.directions_walk
  //                   : _status == 'stopped'
  //                       ? Icons.accessibility_new
  //                       : Icons.error,
  //               size: 100,
  //             ),
  //             Center(
  //               child: Text(
  //                 _status,
  //                 style: _status == 'walking' || _status == 'stopped'
  //                     ? TextStyle(fontSize: 30)
  //                     : TextStyle(fontSize: 20, color: Colors.red),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // ==============================
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Expanded(
            child: Column(
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
                        onPressed: () {
                          context.pushNamed('listStep');
                        },
                        text: 'History',
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
                        'LANGKAH HARIAN',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Rubik',
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 14.0,
                              letterSpacing: 1.0,
                            ),
                      ),
                      FutureBuilder(
                            future: futureStepHarian,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator(),);
                              } else {
                                print(snapshot.data[0]['total_steps']);
                                return Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(48.0, 8.0, 48.0, 0.0),
                                  child: Text(
                                    "Anda telah mencapai ${snapshot.data[0]['total_steps']} langkah dalam sehari",
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Rubik',
                                          fontSize: 24.0,
                                        ),
                                  ),
                                );
                              }
                        }
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            CircularPercentIndicator(
                              percent: 0.8,
                              radius: 90.0,
                              lineWidth: 12.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor: _status == 'walking' ? Color.fromRGBO(23,204,192, 1) : FlutterFlowTheme.of(context).primary,
                              backgroundColor: Color(0x00F1F4F8),
                              startAngle: 216.0,
                            ),
                            CircularPercentIndicator(
                              percent: 0.7,
                              radius: 72.0,
                              lineWidth: 2.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor: _status == 'walking' ? Color.fromRGBO(23,204,192, 1) : Color(0xFFE9E9E9),
                              backgroundColor: Colors.transparent,
                              startAngle: 232.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                    if (startcount) {
                                      startcount = false;
                                      if (_steps != 0 && _steps != '0' && _steps != 'Cek Permision' && _steps != '') {
                                        fitnessFlowDB.createStep(1, _steps);
                                        final snackBar = SnackBar(
                                          /// need to set following properties for best effect of awesome_snackbar_content
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: 'Berhasil!',
                                            message:
                                                'Langkah harian berhasil ditambahkan',
            
                                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                            contentType: ContentType.success,
                                          ),
                                        );
            
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(snackBar);
                                      }
                                      _steps = 'Mulai';
                                    } else {
                                      startcount = true;
                                      _steps = '0';
                                    }
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    _status == 'walking' ? 'assets/images/person.png' : 'assets/images/standing-up-man-.png',
                                    width: 36.0,
                                    height: 36.0,
                                    fit: BoxFit.contain,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 12.0, 0.0, 0.0),
                                    child: Text(
                                      _steps,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Rubik',
                                            fontSize: 20.0,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    startcount ? 'selesai' : 'langkah',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          color: Color(0xFF828282),
                                          fontSize: 12.0,
                                        ),
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 36.0, 24.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              CircularPercentIndicator(
                                percent: 0.5,
                                radius: 30.0,
                                lineWidth: 8.0,
                                animation: true,
                                animateFromLastPercent: true,
                                progressColor: Color(0xFF7EE4F0),
                                backgroundColor: Color(0x4D7EE4F0),
                              ),
                              SvgPicture.asset(
                                'assets/images/trending.svg',
                                width: 24.0,
                                height: 24.0,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                            child: Text(
                              '310 kcal',
                              style:
                                  FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Rubik',
                                        fontSize: 12.0,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                CircularPercentIndicator(
                                  percent: 0.5,
                                  radius: 30.0,
                                  lineWidth: 8.0,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  progressColor: Color(0xFF7165E3),
                                  backgroundColor: Color(0x4D8B80F8),
                                ),
                                SvgPicture.asset(
                                  'assets/images/Location.svg',
                                  width: 24.0,
                                  height: 24.0,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                            child: Text(
                              '4 km',
                              style:
                                  FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Rubik',
                                        fontSize: 12.0,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              CircularPercentIndicator(
                                percent: 0.5,
                                radius: 30.0,
                                lineWidth: 8.0,
                                animation: true,
                                animateFromLastPercent: true,
                                progressColor: Color(0xFF1E87FD),
                                backgroundColor: Color(0x4D1E87FD),
                              ),
                              SvgPicture.asset(
                                'assets/images/stopwatch.svg',
                                width: 24.0,
                                height: 24.0,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                            child: Text(
                              '32 min',
                              style:
                                  FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Rubik',
                                        fontSize: 12.0,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 36.0, 0.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF8B80F8),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(36.0),
                          topRight: Radius.circular(36.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: 'HARI',
                                    options: FFButtonOptions(
                                      width: 96.0,
                                      height: 42.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      color: Color(0x007165E3),
                                      textStyle: GoogleFonts.getFont(
                                        'Rubik',
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text: 'MINGGU',
                                      options: FFButtonOptions(
                                        width: 96.0,
                                        height: 42.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context).primary,
                                        textStyle: GoogleFonts.getFont(
                                          'Rubik',
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: 'BULAN',
                                    options: FFButtonOptions(
                                      width: 96.0,
                                      height: 42.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      color: Color(0x007165E3),
                                      textStyle: GoogleFonts.getFont(
                                        'Rubik',
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 24.0, 12.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 108.0,
                                  child: FlutterFlowLineChart(
                                    data: [
                                      FFLineChartData(
                                        xData: FFAppState().xAxis,
                                        yData: FFAppState().yAxis,
                                        settings: LineChartBarData(
                                          color: Color(0xFF7EE4F0),
                                          barWidth: 2.0,
                                          isCurved: true,
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
