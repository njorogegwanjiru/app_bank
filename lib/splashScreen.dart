import 'package:app_bank/CreateProfile.dart';
import 'package:app_bank/Pages/Dashboard.dart';
import 'package:app_bank/userAPI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onBoarding/onboardingscreens.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  isUserNew() async {
    SharedPreferences appPrefs = await SharedPreferences.getInstance();
    if ((appPrefs.getBool("user_new") ?? false)) {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CreateProfile()));
    } else {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashBoard()));
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FutureBuilder<FirebaseUser>(
                future: getCurrentUser(),
                builder: (BuildContext context,
                    AsyncSnapshot<FirebaseUser> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else if (snapshot.hasData) {
                        return isUserNew();
                      } else
                        return OnboardingScreen();
                  }
                }),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              borderRadius: (BorderRadius.circular(50)),
            ),
            child: Image(
              image: AssetImage(
                'assets/images/flake.png',
              ),
              height: 300.0,
              width: 300.0,
            ),
          ),
        ),
      ),
    );
  }
}
