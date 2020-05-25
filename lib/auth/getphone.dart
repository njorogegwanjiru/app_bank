import 'package:app_bank/onBoarding/onboardingscreens.dart';
import 'package:app_bank/utils/constants.dart';
import 'package:app_bank/utils/styles.dart';
import 'package:app_bank/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../Dashboard.dart';
import '../errorPage.dart';
import '../model/countries.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'verify.dart';
/*
 *  PhoneAuthUI - this file contains whole ui and controllers of ui
 *  Background code will be in other class
 *  code.dart - Class to control background processes in phone auth verification using Firebase
 */

// ignore: must_be_immutable
class PhoneAuthGetPhone extends StatefulWidget {
  /*
   *  cardBackgroundColor & logo values will be passed to the constructor
   *  here we access these params in the _PhoneAuthState using "widget"
   */
  Color cardBackgroundColor = Color(0xFF6874C2);
  String logo = Assets.firebase;
  String appName = "Banking";

  @override
  _PhoneAuthGetPhoneState createState() => _PhoneAuthGetPhoneState();
}

class _PhoneAuthGetPhoneState extends State<PhoneAuthGetPhone> {
  /*
   *  _height & _width:
   *    will be calculated from the MediaQuery of widget's context
   *  countries:
   *    will be a list of Country model, Country model contains name, dialCode, flag and code for various countries
   *    and below params are all related to StreamBuilder
   */
  double _height, _width, _fixedPadding;

  List<Country> countries = [];
  StreamController<List<Country>> _countriesStreamController;
  Stream<List<Country>> _countriesStream;
  Sink<List<Country>> _countriesSink;

  /*
   *  _searchCountryController - This will be used as a controller for listening to the changes what the user is entering
   *  and it's listener will take care of the rest
   */
  TextEditingController _searchCountryController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  /*
   *  This will be the index, we will modify each time the user selects a new country from the dropdown list(dialog),
   *  As a default case, we are using Kenya as default country, index = 44
   */
  int _selectedCountryIndex = 44;

  bool _isCountriesDataFormed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // While disposing the widget, we should close all the streams and controllers

    // Disposing Stream components
//    _countriesSink.close();
//    _countriesStreamController.close();

    // Disposing _countriesSearchController
    _searchCountryController.dispose();
    super.dispose();
  }

  Future<List<Country>> loadCountriesJson() async {
    //  Cleaning up the countries list before we put our data in it
    countries.clear();

    //  Fetching the json file, decoding it and storing each object as Country in countries(list)
    var value = await DefaultAssetBundle.of(context)
        .loadString("data/country_phone_codes.json");
    var countriesJson = json.decode(value);
    for (var country in countriesJson) {
      countries.add(Country.fromJson(country));
    }

    //Finally adding the initial data to the _countriesSink
    // _countriesSink.add(countries);
    return countries;
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DashBoard()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ErrorPage(errorMessage: "User not found.")));
            print("Error");
          }

          //This callback would gets called when verification is done automaticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ErrorPage(errorMessage: exception.toString())));
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PhoneAuthVerify(verificationId, _auth)));
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.025;

    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      if (countries.length < 240) {
        loadCountriesJson().whenComplete(() {
          setState(() => _isCountriesDataFormed = true);
        });
      }
    });

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _getBody(),
        ),
      ),
    );
  }

  Widget _getBody() => SizedBox(
        height: _height * 8 / 10,
        width: _width,
        child: _isCountriesDataFormed
            ? _getColumnBody()
            : Center(child: CircularProgressIndicator()),
      );

  Widget _getColumnBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: _fixedPadding, vertical: 5),
            child: Text(
              'Registration',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: _fixedPadding, left: _fixedPadding),
            child: PhoneAuthWidgets.subTitle('Select your country'),
          ),

          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: _fixedPadding, vertical: 5),
            child: PhoneAuthWidgets.selectCountryDropDown(
                countries[_selectedCountryIndex], showCountries),
          ),

          //  Subtitle for Enter your phone
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: _fixedPadding),
            child: PhoneAuthWidgets.subTitle('Enter your phone'),
          ),
          //  PhoneNumber TextFormFields
          Padding(
            padding: EdgeInsets.only(
                left: _fixedPadding,
                right: _fixedPadding,
                bottom: _fixedPadding),
            child: PhoneAuthWidgets.phoneNumberField(_phoneNumberController,
                countries[_selectedCountryIndex].dialCode),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: _fixedPadding),
              Expanded(
                child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Your ',
                        style: subtitleStyle,
                      ),
                      TextSpan(
                        text: 'One Time Password',
                        style: subtitleStyle,
                      ),
                      TextSpan(
                          text:
                              ' will be sent to this mobile number for verification.',
                          style: subtitleStyle),
                    ])),
              ),
              SizedBox(width: _fixedPadding),
            ],
          ),

          /*
           *  Button: OnTap of this, it appends the dial code and the phone number entered by the user to send OTP,
           *  knowing once the OTP has been sent to the user - the user will be navigated to a new Screen,
           *  where is asked to enter the OTP he has received on his mobile (or) wait for the system to automatically detect the OTP
           */
          SizedBox(height: _fixedPadding * 1.5),
          RaisedButton(
            elevation: 16.0,
            onPressed: () {
              final phone =
                  countries[_selectedCountryIndex].dialCode.toString().trim() +
                      _phoneNumberController.text.trim();

              loginUser(phone, context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'SEND OTP',
                style: TextStyle(
                    color: widget.cardBackgroundColor, fontSize: 18.0),
              ),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ],
      );

  showCountries() {
    /*
     * Initialising components required for StreamBuilder
     * We will not be using _countriesStreamController anywhere, but just to initialize Stream & Sink from that
     * _countriesStream will give us the data what we need(output) - that will be used in StreamBuilder widget
     * _countriesSink is the place where we send the data(input)
     */
    _countriesStreamController = StreamController();
    _countriesStream = _countriesStreamController.stream;
    _countriesSink = _countriesStreamController.sink;
    _countriesSink.add(countries);

    _searchCountryController.addListener(searchCountries);

    showDialog(
        context: context,
        builder: (BuildContext context) => searchAndPickYourCountryHere(),
        barrierDismissible: false);
  }

  /*
   *  This will be the listener for searching the query entered by user for their country, (dialog pop-up),
   *  searches for the query and returns list of countries matching the query by adding the results to the sink of _countriesStream
   */
  searchCountries() {
    String query = _searchCountryController.text;
    if (query.length == 0 || query.length == 1) {
      if (!_countriesStreamController.isClosed) _countriesSink.add(countries);
//      print('added all countries again');
    } else if (query.length >= 2 && query.length <= 5) {
      List<Country> searchResults = [];
      searchResults.clear();
      countries.forEach((Country c) {
        if (c.toString().toLowerCase().contains(query.toLowerCase()))
          searchResults.add(c);
      });
      _countriesSink.add(searchResults);
//      print('added few countries based on search ${searchResults.length}');
    } else {
      //No results
      List<Country> searchResults = [];
      _countriesSink.add(searchResults);
//      print('no countries added');
    }
  }

  /*
   * Child for Dialog
   * Contents:
   *    SearchCountryTextFormField
   *    StreamBuilder
   *      - Shows a list of countries
   */
  Widget searchAndPickYourCountryHere() => WillPopScope(
        onWillPop: () => Future.value(false),
        child: Dialog(
          key: Key('SearchCountryDialog'),
          elevation: 8.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //  TextFormField for searching country
                  PhoneAuthWidgets.searchCountry(_searchCountryController),

                  //  Returns a list of Countries that will change according to the search query
                  SizedBox(
                    height: 300.0,
                    child: StreamBuilder<List<Country>>(
                        //key: Key('Countries-StreamBuilder'),
                        stream: _countriesStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // print(snapshot.data.length);
                            return snapshot.data.length == 0
                                ? Center(
                                    child: Text('Your search found no results',
                                        style: TextStyle(fontSize: 16.0)),
                                  )
                                : ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int i) =>
                                            PhoneAuthWidgets.selectableWidget(
                                                snapshot.data[i],
                                                (Country c) =>
                                                    selectThisCountry(c)),
                                  );
                          } else if (snapshot.hasError)
                            return Center(
                              child: Text('Seems, there is an error',
                                  style: TextStyle(fontSize: 16.0)),
                            );
                          return Center(child: CircularProgressIndicator());
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  /*
   *  This callback is triggered when the user taps(selects) on any country from the available list in dialog
   *    Resets the search value
   *    Close the stream & sink
   *    Updates the selected Country and adds dialCode as prefix according to the user's selection
   */
  void selectThisCountry(Country country) {
    print(country);
    _searchCountryController.clear();
    Navigator.of(context).pop();
    Future.delayed(Duration(milliseconds: 10)).whenComplete(() {
      _countriesStreamController.close();
      _countriesSink.close();

      setState(() {
        _selectedCountryIndex = countries.indexOf(country);
      });
    });
  }
}
