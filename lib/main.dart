import 'package:app_bank/Dashboard.dart';
import 'package:app_bank/onBoarding/onboardingscreens.dart';
import 'package:app_bank/splashScreen.dart';
import 'package:app_bank/userAPI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/themes.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt("initScreen");
  await preferences.setInt("initScreen", 1);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
//    Widget home;
//
//    getCurrentUser().then((u) {
//      if (u == null) {
//        print('USER IS NULL');
//        setState(() {
//          home = OnboardingScreen();
//        });
//      } else {
//        print('USER IS NOT NULL');
//        setState(() {
//          home = DashBoard();
//        });
//      }
//    });
    return MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: SplashScreen());

//    return MaterialApp(
//
//      debugShowCheckedModeBanner: false,
//      initialRoute: initScreen == 0 || initScreen==null? "first": "/",
//      routes: {
//        '/': (context)=> PhoneAuthGetPhone(),
//        "first": (context)=> OnboardingScreen(),
//      },
//    );
  }
}
