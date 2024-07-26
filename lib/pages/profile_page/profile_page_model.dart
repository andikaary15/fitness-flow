import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNodeNama;
  TextEditingController? textControllerNama;
  FocusNode? textFieldFocusNodePassword;
  TextEditingController? textControllerPassword;
  FocusNode? textFieldFocusNodeUmur;
  TextEditingController? textControllerUmur;
  FocusNode? textFieldFocusNodeBerat;
  TextEditingController? textControllerBerat;
  FocusNode? textFieldFocusNodeTinggi;
  TextEditingController? textControllerTinggi;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNodeNama?.dispose();
    textControllerNama?.dispose();
    textFieldFocusNodePassword?.dispose();
    textControllerPassword?.dispose();
    textFieldFocusNodeUmur?.dispose();
    textControllerUmur?.dispose();
    textFieldFocusNodeBerat?.dispose();
    textControllerBerat?.dispose();
    textFieldFocusNodeTinggi?.dispose();
    textControllerTinggi?.dispose();
  }
  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
