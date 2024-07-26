import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fitness_flow/services/fitness_flow_db.dart';
import 'package:flutter/widgets.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'events_page_model.dart';
export 'events_page_model.dart';

class EventsPageWidget extends StatefulWidget {
  const EventsPageWidget({super.key});

  @override
  State<EventsPageWidget> createState() => _EventsPageWidgetState();
}

class _EventsPageWidgetState extends State<EventsPageWidget>
    with TickerProviderStateMixin {
  late EventsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hariini = DateFormat('yyyy-MM-dd').format(DateTime.now());

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
          begin: Offset(0.0, 20.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
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
  };

  Future? futureUser;
  var futureUserSession;
  Future? futureLatihanHarian;
  final fitnessFlowDB = FitnessFlowDB();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventsPageModel());
    latihanHarian(hariini);
  }


  latihanHarian(date) {
    setState((){
      futureLatihanHarian = fitnessFlowDB.fetchLatihanHarian(date);
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 48.0, 24.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              context.pushNamed('HomePage');
                            },
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 48.0,
                            icon: FaIcon(
                              FontAwesomeIcons.calendarPlus,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 20.0,
                            ),
                            onPressed: () {
                              context.pushNamed('FormAddWork');
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 0.0),
                        child: Text(
                          'Latihan',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Rubik',
                                fontSize: 24.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: 
                      List.generate(6, (index) {
                        DateTime date = DateTime.now().subtract(Duration(days: 5-index));
                        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              latihanHarian(formattedDate);
                              hariini = formattedDate;
                            });
                          },
                          child: Container(
                            width: 64.0,
                            height: 96.0,
                            decoration: BoxDecoration(
                              color: formattedDate == hariini ?  FlutterFlowTheme.of(context).primary :Color(0x007165E3),
                              borderRadius: BorderRadius.circular(48.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 0.0, 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat.E().format(date).toUpperCase(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          color: formattedDate == hariini ? Colors.white : FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  Container(
                                    width: 36.0,
                                    height: 36.0,
                                    decoration: BoxDecoration(
                                      color: formattedDate == hariini ? FlutterFlowTheme.of(context)
                                                    .secondaryBackground : Color(0x00F5F6FA),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Text(
                                      DateFormat.d().format(date),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Rubik',
                                            color: formattedDate == hariini ? FlutterFlowTheme.of(context)
                                                          .secondary:FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 36.0, 24.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FutureBuilder(
                        future: futureLatihanHarian,
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
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) { 
                                var itemData = snapshot.data[index];
                                return Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.of(context).primaryBackground,
                                        borderRadius: BorderRadius.circular(24.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 144.0,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.network(
                                                  itemData['gambar'] ?? '',
                                                ).image,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0.0),
                                                bottomRight: Radius.circular(0.0),
                                                topLeft: Radius.circular(24.0),
                                                topRight: Radius.circular(24.0),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                      16.0, 16.0, 16.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      FlutterFlowIconButton(
                                                        borderColor: Colors.transparent,
                                                        borderRadius: 12.0,
                                                        borderWidth: 1.0,
                                                        buttonSize: 36.0,
                                                        fillColor:
                                                            FlutterFlowTheme.of(context)
                                                                .primaryBackground,
                                                        icon: FaIcon(
                                                          itemData['status'] == 'belum' ? FontAwesomeIcons.timesCircle : FontAwesomeIcons.solidCheckCircle,
                                                          color:
                                                              FlutterFlowTheme.of(context)
                                                                  .primary,
                                                          size: 14.0,
                                                        ),
                                                        onPressed: () async {
                                                          await fitnessFlowDB.changeStatusLatihan(itemData['workout_user_id'], itemData['status'] == 'belum' ? 'sudah' : 'belum');
                                                          setState(() {
                                                            latihanHarian(hariini);
                                                          });
                                                          final snackBar = SnackBar(
                                                            /// need to set following properties for best effect of awesome_snackbar_content
                                                            elevation: 0,
                                                            behavior: SnackBarBehavior.floating,
                                                            backgroundColor: Colors.transparent,
                                                            content: AwesomeSnackbarContent(
                                                              title: 'Berhasil!',
                                                              message:
                                                                  'Status Latihan berhasil diubah',
          
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
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                      16.0, 16.0, 16.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      FlutterFlowIconButton(
                                                        borderColor: Colors.transparent,
                                                        borderRadius: 12.0,
                                                        borderWidth: 1.0,
                                                        buttonSize: 36.0,
                                                        fillColor:
                                                            FlutterFlowTheme.of(context)
                                                                .primaryBackground,
                                                        icon: FaIcon(
                                                          FontAwesomeIcons.trashAlt ,
                                                          color: Colors.red,
                                                          size: 14.0,
                                                        ),
                                                        onPressed: () async {
                                                          await fitnessFlowDB.deleteLatihanHarian(itemData['workout_user_id']);
                                                          setState(() {
                                                            latihanHarian(hariini);
                                                          });
                                                          final snackBar = SnackBar(
                                                            /// need to set following properties for best effect of awesome_snackbar_content
                                                            elevation: 0,
                                                            behavior: SnackBarBehavior.floating,
                                                            backgroundColor: Colors.transparent,
                                                            content: AwesomeSnackbarContent(
                                                              title: 'Berhasil!',
                                                              message:
                                                                  'Latihan berhasil dihapus',
          
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
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(24.0),
                                                bottomRight: Radius.circular(24.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(24.0),
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
                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                        0.0, 8.0, 0.0, 0.0),
                                                    child: Text(
                                                      itemData['nama'],
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Rubik',
                                                            fontSize: 16.0,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                        0.0, 6.0, 0.0, 0.0),
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
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                        0.0, 24.0, 0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            await launchURL(itemData['link']);
                                                          },
                                                          text: 'Mulai',
                                                          options: FFButtonOptions(
                                                            height: 42.0,
                                                            padding: EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    24.0, 0.0, 24.0, 0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0, 0.0, 0.0, 0.0),
                                                            color:
                                                                FlutterFlowTheme.of(context)
                                                                    .tertiary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily: 'Rubik',
                                                                      color: FlutterFlowTheme
                                                                              .of(context)
                                                                          .primary,
                                                                      fontSize: 14.0,
                                                                      fontWeight:
                                                                          FontWeight.normal,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderSide: BorderSide(
                                                              color: Colors.transparent,
                                                              width: 0.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(12.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).animateOnPageLoad(
                                      animationsMap['containerOnPageLoadAnimation1']!),
                                );
                              }
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
        ),
      ),
    );
  }
}
