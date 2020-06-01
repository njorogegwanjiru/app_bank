import 'package:app_bank/Dashboard.dart';
import 'package:app_bank/errorPage.dart';
import 'package:app_bank/onBoarding/onboardingscreens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'code.dart';
import '../utils/widgets.dart';
import '../utils/constants.dart';

// ignore: must_be_immutable
class PhoneAuthVerify extends StatefulWidget {
  String verificationId;
  FirebaseAuth _auth;

  PhoneAuthVerify(this.verificationId, this._auth);

  @override
  _PhoneAuthVerifyState createState() => _PhoneAuthVerifyState();
}

class _PhoneAuthVerifyState extends State<PhoneAuthVerify> {
  double _height, _width, _fixedPadding;
  bool _requested = false;

  TextEditingController _codeController = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  String code = "";

  @override
  void initState() {
    FirebasePhoneAuth.phoneAuthState.stream
        .listen((PhoneAuthState state) => print(state));
    super.initState();
  }

  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-verify-phone");

  @override
  Widget build(BuildContext context) {
    //  Fetching height & width parameters from the MediaQuery
    //  _logoPadding will be a constant, scaling it according to device's size
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.025;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Verification"),
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _getBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBody() => SizedBox(
        height: _height * 8 / 10,
        width: _width,
        child: _getColumnBody(),
      );

  Widget _getColumnBody() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Text(
                    "Please enter the code sent to your phone",
                    style: Theme.of(context).textTheme.subtitle,
                  )),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.05),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getPinField(key: "1", focusNode: focusNode1),
              SizedBox(width: 5.0),
              getPinField(key: "2", focusNode: focusNode2),
              SizedBox(width: 5.0),
              getPinField(key: "3", focusNode: focusNode3),
              SizedBox(width: 5.0),
              getPinField(key: "4", focusNode: focusNode4),
              SizedBox(width: 5.0),
              getPinField(key: "5", focusNode: focusNode5),
              SizedBox(width: 5.0),
              getPinField(key: "6", focusNode: focusNode6),
              SizedBox(width: 5.0),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Container(
            child: _requested
                ? CircularProgressIndicator()
                : getOutlineButton("VERIFY", () async {
                    setState(() {
                      _requested = true;
                    });
                    final code = _codeController.text.trim();
                    if (code.length != 6) {
                      _showSnackBar("Invalid OTP");
                    }
                    AuthCredential credential = PhoneAuthProvider.getCredential(
                        verificationId: widget.verificationId, smsCode: code);
                    AuthResult result =
                        await widget._auth.signInWithCredential(credential);

                    FirebaseUser user = result.user;

                    if (user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DashBoard()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ErrorPage(errorMessage: "User not found.")));
                      print("Error");
                    }
                  }, Theme.of(context).textTheme.subtitle),
          )
//          FlatButton(
//            onPressed: () async {
//              final code = _codeController.text.trim();
//              AuthCredential credential = PhoneAuthProvider.getCredential(
//                  verificationId: widget.verificationId, smsCode: code);
//
//              AuthResult result =
//                  await widget._auth.signInWithCredential(credential);
//
//              FirebaseUser user = result.user;
//
//              if (user != null) {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => DashBoard()));
//              } else {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) =>
//                            ErrorPage(errorMessage: "User not found.")));
//                print("Error");
//              }
//            },
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(5.0),
//                side: BorderSide(color: Colors.black)),
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text('VERIFY', style: Theme.of(context).textTheme.subhead),
//            ),
//          )
        ],
      );

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
      duration: Duration(seconds: 2),
    );
//    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
        height: 40.0,
        width: 35.0,
        child: TextField(
          key: Key(key),
          expands: false,
          autofocus: false,
          focusNode: focusNode,
          onChanged: (String value) {
            if (value.length == 1) {
              code += value;
              switch (code.length) {
                case 1:
                  FocusScope.of(context).requestFocus(focusNode2);
                  break;
                case 2:
                  FocusScope.of(context).requestFocus(focusNode3);
                  break;
                case 3:
                  FocusScope.of(context).requestFocus(focusNode4);
                  break;
                case 4:
                  FocusScope.of(context).requestFocus(focusNode5);
                  break;
                case 5:
                  FocusScope.of(context).requestFocus(focusNode6);
                  break;
                default:
                  FocusScope.of(context).requestFocus(FocusNode());
                  break;
              }
            }
          },
          maxLengthEnforced: false,
          textAlign: TextAlign.center,
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.subtitle,
        ),
      );

  onStarted() {
    _showSnackBar("PhoneAuth started");
  }

  onCodeSent() {
    _showSnackBar("OPT sent");
  }

  onCodeResent() {
    _showSnackBar("OPT resent");
  }

  onFailed() {
    _showSnackBar("PhoneAuth failed");
  }

// This will return pin field - it accepts only single char
//  Widget getPinField({String key, FocusNode focusNode}) {
//    return SizedBox(
//      height: 40.0,
//      width: 35.0,
//      child: TextField(
//        key: Key(key),
//        maxLength: 1,
//
//        expands: false,
//        autofocus: key.contains("1") ? true : false,
//        focusNode: focusNode,
//        onChanged: (String value) {
//
//          if (value.length != 6) {
//            code += value;
//            switch (code.length) {
//              case 1:
//                FocusScope.of(context).requestFocus(focusNode2);
//                break;
//              case 2:
//                FocusScope.of(context).requestFocus(focusNode3);
//                break;
//              case 3:
//                FocusScope.of(context).requestFocus(focusNode4);
//                break;
//              case 4:
//                FocusScope.of(context).requestFocus(focusNode5);
//                break;
//              case 5:
//                FocusScope.of(context).requestFocus(focusNode6);
//                break;
//              default:
//                FocusScope.of(context).requestFocus(FocusNode());
//                break;
//            }
//          }
//        },
//        maxLengthEnforced: false,
//        textAlign: TextAlign.center,
//        cursorColor: Colors.black,
//        keyboardType: TextInputType.number,
//        style: TextStyle(
//            fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
//        decoration: InputDecoration(
//            counterText: "",
//            contentPadding: const EdgeInsets.only(
//                bottom: 10.0, top: 10.0, left: 4.0, right: 4.0),
//            focusedBorder: OutlineInputBorder(
//                borderRadius: BorderRadius.circular(5.0),
//                borderSide:
//                BorderSide(color: Theme.of(context).colorScheme.secondary, width: 2.25)),
//            border: OutlineInputBorder(
//                borderRadius: BorderRadius.circular(5.0),
//                borderSide: BorderSide(color: Colors.white))),
//        controller: _codeController,
//      ),
//    );
//  }
}
