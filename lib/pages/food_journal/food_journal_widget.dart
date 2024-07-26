import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fitness_flow/services/fitness_flow_db.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'food_journal_model.dart';
export 'food_journal_model.dart';

class FoodJournalWidget extends StatefulWidget {
  const FoodJournalWidget({super.key});

  @override
  State<FoodJournalWidget> createState() => _FoodJournalWidgetState();
}

class _FoodJournalWidgetState extends State<FoodJournalWidget> {
  late FoodJournalModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hariini = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FoodJournalModel());
    fetchUser();
    fetchMeals(hariini);
    jurnalHarian(hariini);
  }

  Future? futureUser;
  var futureUserSession;
  Future? futureKaloriHarian;
  Future? futureMealBreakfast;
  Future? futureMealLunch;
  Future? futureMealDinner;
  final fitnessFlowDB = FitnessFlowDB();


  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void fetchMeals(date) async {
    setState((){
      futureMealBreakfast = fitnessFlowDB.fetchMealDaily('Breakfast', date);
      futureMealLunch = fitnessFlowDB.fetchMealDaily('Lunch', date);
      futureMealDinner = fitnessFlowDB.fetchMealDaily('Dinner', date);
    });
  }

  void fetchUser() async {
    setState((){
      futureUser = fitnessFlowDB.fetchUserById(1);
    });
  }

  jurnalHarian(date) {
    setState((){
      futureKaloriHarian = fitnessFlowDB.fetchKaloriHarianGroup(date);
      fetchMeals(date);
    });
  }

  deleteMealJurnal(id) {
    setState(() {
      fitnessFlowDB.deleteMealJurnal(id);
      fetchMeals(hariini);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondary,
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
                      context.pop();
                    },
                  ),
                  Text(
                    'Jurnal',
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 48.0, 24.0, 0.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    // Calculate the date for each container
                    DateTime date = DateTime.now().subtract(Duration(days: 5-index));
                    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                    // if (formattedDate == formattedDateNow) {
                    //   hariini = formattedDateNow;
                    // }
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          jurnalHarian(formattedDate);
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
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat.E().format(date).toUpperCase(), // Display day of week
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Rubik',
                                  color: Color(0xFFF2F2F2),
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
                                alignment: Alignment.center,
                                child: Text(
                                  DateFormat.d().format(date), // Display day of month
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Rubik',
                                    color: formattedDate == hariini ? FlutterFlowTheme.of(context)
                                                        .secondary:Colors.white,
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

            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(36.0),
                      topRight: Radius.circular(36.0),
                    ),
                  ),
                  child: FutureBuilder(
                  future: futureKaloriHarian,
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(),);
                    } else {
                      var totalkalori = 0.0;
                      if (snap.data != null) {
                        totalkalori = (snap.data[0]['breakfast'] + snap.data[0]['lunch'] + snap.data[0]['dinner']).toDouble();
                      }

                      return Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 24.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'BREAKFAST',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Rubik',
                                                        color: FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.4,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/trending2.svg',
                                                        width: 24.0,
                                                        height: 24.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(8.0, 0.0,
                                                                    0.0, 0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "${snap.data[0]['breakfast']}",
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    fontSize: 24.0,
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          2.0),
                                                              child: Text(
                                                                'cal/$totalkalori cal',
                                                                style: FlutterFlowTheme
                                                                        .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Rubik',
                                                                      fontSize:
                                                                          12.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
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
                                          ],
                                        ),
                                        Divider(
                                          height: 48.0,
                                          thickness: 1.0,
                                          color: Color(0xFFE9E9E9),
                                        ),
                                        FutureBuilder(
                                          future: futureMealBreakfast,
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
                                                    return Column(
                                                      children: [
                                          
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Container(
                                                                  width: 60.0,
                                                                  height: 60.0,
                                                                  decoration: BoxDecoration(
                                                                    color: FlutterFlowTheme.of(context)
                                                                        .secondaryBackground,
                                                                    image: DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: Image.network(
                                                                        itemData['gambar'],
                                                                      ).image,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(16.0),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            12.0, 0.0, 0.0, 0.0),
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment.start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          "${itemData['nama']}",
                                                                          style: FlutterFlowTheme.of(
                                                                                  context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Rubik',
                                                                                fontWeight:
                                                                                    FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                                  0.0, 6.0, 0.0, 0.0),
                                                                          child: RichText(
                                                                            textScaler:
                                                                                MediaQuery.of(context)
                                                                                    .textScaler,
                                                                            text: TextSpan(
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: "${itemData['kalori']}",
                                                                                  style: TextStyle(),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: ' cal',
                                                                                  style: TextStyle(),
                                                                                )
                                                                              ],
                                                                              style: FlutterFlowTheme
                                                                                      .of(context)
                                                                                  .bodyMedium
                                                                                  .override(
                                                                                    fontFamily: 'Rubik',
                                                                                    fontSize: 12.0,
                                                                                    fontWeight:
                                                                                        FontWeight
                                                                                            .normal,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                          6.0, 0.0, 0.0, 0.0),
                                                                  child: FlutterFlowIconButton(
                                                                    borderColor: Colors.transparent,
                                                                    borderRadius: 12.0,
                                                                    borderWidth: 1.0,
                                                                    buttonSize: 36.0,
                                                                    fillColor: Colors.transparent,
                                                                    icon: FaIcon(
                                                                      FontAwesomeIcons.trashAlt,
                                                                      color: Color(0xFFBDBDBD),
                                                                      size: 16.0,
                                                                    ),
                                                                    onPressed: () {
                                                                      deleteMealJurnal(itemData['kalori_user_id']);
                                                                      final snackBar = SnackBar(
                                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                                        elevation: 0,
                                                                        behavior: SnackBarBehavior.floating,
                                                                        backgroundColor: Colors.transparent,
                                                                        content: AwesomeSnackbarContent(
                                                                          title: 'Berhasil!',
                                                                          message:
                                                                              'Kalori harian berhasil dihapus',

                                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                          contentType: ContentType.success,
                                                                        ),
                                                                      );

                                                                      ScaffoldMessenger.of(context)
                                                                        ..hideCurrentSnackBar()
                                                                        ..showSnackBar(snackBar);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              height: 48.0,
                                                              thickness: 1.0,
                                                              color: Color(0xFFE9E9E9),
                                                            ),
                                                      ],
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
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 24.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'LUNCH',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Rubik',
                                                        color: FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.4,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/trending2.svg',
                                                        width: 24.0,
                                                        height: 24.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(8.0, 0.0,
                                                                    0.0, 0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "${snap.data[0]['lunch']}",
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    fontSize: 24.0,
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          2.0),
                                                              child: Text(
                                                                'cal/$totalkalori cal',
                                                                style: FlutterFlowTheme
                                                                        .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Rubik',
                                                                      fontSize:
                                                                          12.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
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
                                          ],
                                        ),
                                        Divider(
                                          height: 48.0,
                                          thickness: 1.0,
                                          color: Color(0xFFE9E9E9),
                                        ),
                                        FutureBuilder(
                                          future: futureMealLunch,
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
                                                    return Column(
                                                      children: [
                                          
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Container(
                                                                  width: 60.0,
                                                                  height: 60.0,
                                                                  decoration: BoxDecoration(
                                                                    color: FlutterFlowTheme.of(context)
                                                                        .secondaryBackground,
                                                                    image: DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: Image.network(
                                                                        itemData['gambar'],
                                                                      ).image,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(16.0),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            12.0, 0.0, 0.0, 0.0),
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment.start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          "${itemData['nama']}",
                                                                          style: FlutterFlowTheme.of(
                                                                                  context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Rubik',
                                                                                fontWeight:
                                                                                    FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                                  0.0, 6.0, 0.0, 0.0),
                                                                          child: RichText(
                                                                            textScaler:
                                                                                MediaQuery.of(context)
                                                                                    .textScaler,
                                                                            text: TextSpan(
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: "${itemData['kalori']}",
                                                                                  style: TextStyle(),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: ' cal',
                                                                                  style: TextStyle(),
                                                                                )
                                                                              ],
                                                                              style: FlutterFlowTheme
                                                                                      .of(context)
                                                                                  .bodyMedium
                                                                                  .override(
                                                                                    fontFamily: 'Rubik',
                                                                                    fontSize: 12.0,
                                                                                    fontWeight:
                                                                                        FontWeight
                                                                                            .normal,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                          6.0, 0.0, 0.0, 0.0),
                                                                  child: FlutterFlowIconButton(
                                                                    borderColor: Colors.transparent,
                                                                    borderRadius: 12.0,
                                                                    borderWidth: 1.0,
                                                                    buttonSize: 36.0,
                                                                    fillColor: Colors.transparent,
                                                                    icon: FaIcon(
                                                                      FontAwesomeIcons.trashAlt,
                                                                      color: Color(0xFFBDBDBD),
                                                                      size: 16.0,
                                                                    ),
                                                                    onPressed: () {
                                                                      deleteMealJurnal(itemData['kalori_user_id']);
                                                                      final snackBar = SnackBar(
                                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                                        elevation: 0,
                                                                        behavior: SnackBarBehavior.floating,
                                                                        backgroundColor: Colors.transparent,
                                                                        content: AwesomeSnackbarContent(
                                                                          title: 'Berhasil!',
                                                                          message:
                                                                              'Kalori harian berhasil dihapus',

                                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                          contentType: ContentType.success,
                                                                        ),
                                                                      );

                                                                      ScaffoldMessenger.of(context)
                                                                        ..hideCurrentSnackBar()
                                                                        ..showSnackBar(snackBar);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              height: 48.0,
                                                              thickness: 1.0,
                                                              color: Color(0xFFE9E9E9),
                                                            ),
                                                      ],
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
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'DINNER',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Rubik',
                                                        color: FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.4,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/trending2.svg',
                                                        width: 24.0,
                                                        height: 24.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(8.0, 0.0,
                                                                    0.0, 0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              '${snap.data[0]['dinner']}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    fontSize: 24.0,
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          2.0),
                                                              child: Text(
                                                                'cal/$totalkalori cal',
                                                                style: FlutterFlowTheme
                                                                        .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Rubik',
                                                                      fontSize:
                                                                          12.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
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
                                          ],
                                        ),
                                        Divider(
                                          height: 48.0,
                                          thickness: 1.0,
                                          color: Color(0xFFE9E9E9),
                                        ),
                                        FutureBuilder(
                                          future: futureMealDinner,
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
                                                    return Column(
                                                      children: [
                                          
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Container(
                                                                  width: 60.0,
                                                                  height: 60.0,
                                                                  decoration: BoxDecoration(
                                                                    color: FlutterFlowTheme.of(context)
                                                                        .secondaryBackground,
                                                                    image: DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: Image.network(
                                                                        itemData['gambar'],
                                                                      ).image,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(16.0),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            12.0, 0.0, 0.0, 0.0),
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment.start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          "${itemData['nama']}",
                                                                          style: FlutterFlowTheme.of(
                                                                                  context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Rubik',
                                                                                fontWeight:
                                                                                    FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                                  0.0, 6.0, 0.0, 0.0),
                                                                          child: RichText(
                                                                            textScaler:
                                                                                MediaQuery.of(context)
                                                                                    .textScaler,
                                                                            text: TextSpan(
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: "${itemData['kalori']}",
                                                                                  style: TextStyle(),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: ' cal',
                                                                                  style: TextStyle(),
                                                                                )
                                                                              ],
                                                                              style: FlutterFlowTheme
                                                                                      .of(context)
                                                                                  .bodyMedium
                                                                                  .override(
                                                                                    fontFamily: 'Rubik',
                                                                                    fontSize: 12.0,
                                                                                    fontWeight:
                                                                                        FontWeight
                                                                                            .normal,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                          6.0, 0.0, 0.0, 0.0),
                                                                  child: FlutterFlowIconButton(
                                                                    borderColor: Colors.transparent,
                                                                    borderRadius: 12.0,
                                                                    borderWidth: 1.0,
                                                                    buttonSize: 36.0,
                                                                    fillColor: Colors.transparent,
                                                                    icon: FaIcon(
                                                                      FontAwesomeIcons.trashAlt,
                                                                      color: Color(0xFFBDBDBD),
                                                                      size: 16.0,
                                                                    ),
                                                                    onPressed: () {
                                                                      deleteMealJurnal(itemData['kalori_user_id']);
                                                                      final snackBar = SnackBar(
                                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                                        elevation: 0,
                                                                        behavior: SnackBarBehavior.floating,
                                                                        backgroundColor: Colors.transparent,
                                                                        content: AwesomeSnackbarContent(
                                                                          title: 'Berhasil!',
                                                                          message:
                                                                              'Kalori harian berhasil dihapus',

                                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                          contentType: ContentType.success,
                                                                        ),
                                                                      );

                                                                      ScaffoldMessenger.of(context)
                                                                        ..hideCurrentSnackBar()
                                                                        ..showSnackBar(snackBar);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              height: 48.0,
                                                              thickness: 1.0,
                                                              color: Color(0xFFE9E9E9),
                                                            ),
                                                      ],
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
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
