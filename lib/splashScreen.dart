import 'package:app_bank/CreateProfile.dart';
import 'package:app_bank/Dashboard.dart';
import 'package:app_bank/userAPI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'onBoarding/onboardingscreens.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
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
                      else if (snapshot.hasData)
                        return CreateProfile();
                      else
                        return OnboardingScreen();
                  }
                }),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Image(
          image: AssetImage(
            'assets/images/onboarding0.png',
          ),
          height: 300.0,
          width: 300.0,
        ),
      ),
    );
  }
}
