import 'package:app_bank/PinPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/user.dart';

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
    getUser().then((user) {
      theUser = user;
    });
  }

  User theUser;

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  Future<User> getUser() async {
    User result = (await FirebaseDatabase.instance
            .reference()
            .child("Members")
            .child("MemberIdNo")
            .equalTo("123")
            .once())
        .value;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(theUser.toString()),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[Text("")],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
