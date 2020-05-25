import 'package:app_bank/PinPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashBoard extends StatefulWidget {

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  FirebaseUser currentUser;
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.account_circle),
        centerTitle: true,
        title: Text(this.currentUser.uid),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (c) => AlertDialog(
                    title: Text('Log Out'),
                    content: Text('Confirm Log out?'),
                    actions: <Widget>[
                      FlatButton(
                          child: Text('Yes'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PinPage()));

                          }),
                      FlatButton(
                        child: Text('No'),
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true)
                                .pop(),
                      ),
                    ],
                  ));
            },
            iconSize: 30,
            color: Colors.white,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "You are Logged in succesfully",
              style: Theme.of(context).textTheme.subtitle,
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
