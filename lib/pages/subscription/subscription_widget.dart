import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fitness_flow/services/fitness_flow_db.dart';
import 'package:image_picker/image_picker.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'subscription_model.dart';
export 'subscription_model.dart';

class SubscriptionWidget extends StatefulWidget {
  const SubscriptionWidget({super.key});

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  late SubscriptionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future? futureUser;
  String? byte64String;
  final fitnessFlowDB = FitnessFlowDB();
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubscriptionModel());
    _model.textController ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.textFieldFocusNode2 ??= FocusNode();
    fetchUser();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void fetchUser() async {
    setState((){
      futureUser = fitnessFlowDB.fetchUserByIdV2(1);
    });
  }


  Future<String> pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 45);

    var imageBytes = await image!.readAsBytes();


    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }


  _showDatePicker() {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2050)).then((value) {
      setState(() {
        _model.textController2.text = DateFormat('yyyy-MM-dd').format(value!);
      });
    });
  }

  createBeratBadan() async {
    var user = await fitnessFlowDB.fetchUserByIdV2(1);
    fitnessFlowDB.updateUser(1, 'berat_old', user[0]['berat'].toString());
    fitnessFlowDB.createBeratBadan(1, _model.textController.text, _model.textController2.text, byte64String);
    fitnessFlowDB.updateUser(1, 'berat', _model.textController.text);
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Tambah',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Rubik',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                      child: Text(
                        'Berat Badan',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Rubik',
                              fontSize: 18.0,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                  Form(
                    child: Column(
                        children: [
                          TextFormField(
                            controller: _model.textController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: const BorderSide(width: 2,color: Color.fromRGBO(80, 70, 227, 1))
                              ),
                              label: Text("Berat", style: GoogleFonts.poppins(),),
                              floatingLabelStyle: GoogleFonts.poppins(color: Color.fromRGBO(80, 70, 227, 1)),
                              // prefixIcon: const Icon(FontAwesomeIcons.rupiahSign, size: 18,),
                              prefixIconColor:  const Color.fromRGBO(80, 70, 227, 1),
                              
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: _model.textController2,
                            onTap: () {
                              _showDatePicker();
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: const BorderSide(width: 2,color: Color.fromRGBO(80, 70, 227, 1))
                              ),
                              label: Text("Tanggal", style: GoogleFonts.poppins(),),
                              floatingLabelStyle: GoogleFonts.poppins(color: Color.fromRGBO(80, 70, 227, 1)),
                              // prefixIcon: const Icon(Icon.calendar, size: 18,),
                              prefixIconColor:  const Color.fromRGBO(80, 70, 227, 1),
                              
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: byte64String != null ? Image.memory(const Base64Decoder().convert(byte64String!)) : SvgPicture.asset(
                                    'assets/images/camera.svg',
                                    height: 220.0,
                                    fit: BoxFit.cover
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 180,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      byte64String = await pickImage();
                                      setState(() {
                                        byte64String = byte64String;
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(80, 70, 227, 1)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                      ),
                                      padding: MaterialStateProperty.all<EdgeInsets>( const EdgeInsets.all(10))
                                    ),
                                    child: Text(
                                      "Unggah Gambar",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600, 
                                        fontSize: 15,
                                      ),
                                    )
                                  ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30,),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (byte64String != null && _model.textController.text != '' && _model.textController2.text != '') {
                                    await createBeratBadan();

                                  final snackBar = SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Berhasil!',
                                      message:
                                          'Berat badan berhasil ditambahkan',

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.success,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                  context.pushNamed('WeightTracker');
                                    
                                  } else {

                                  final snackBar = SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Perhatian!',
                                      message:
                                          'Harap periksa dan lengkapi form anda',

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.warning,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(240,0,185,1)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    )
                                  ),
                                  padding: MaterialStateProperty.all<EdgeInsets>( const EdgeInsets.all(20))
                                ),
                                child: Text(
                                  "Simpan",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, 
                                    fontSize: 20,
                                  ),
                                )
                              ),
                          ),
                        ],
                      )
                  ),
                    ],
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
