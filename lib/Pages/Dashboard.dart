import 'package:app_bank/Pages/FundsTransfer.dart';
import 'package:app_bank/Pages/LoanMenu.dart';
import 'package:app_bank/Pages/MyCards.dart';
import 'package:app_bank/Pages/Settings.dart';
import 'package:app_bank/Pages/TransactionHistory.dart';
import 'package:app_bank/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_bank/PinPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user.dart';
import 'Loans.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  FirebaseUser currentUser;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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

  Widget drawerListTile(icon, String label, Function onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.surface,
      ),
      title: Text(
        label,
        style: Theme.of(context).textTheme.body2,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: SafeArea(
        child: Drawer(
          elevation: 5,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[Text("//TODO :account info")],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              drawerListTile(Icons.credit_card, 'My Account', () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAccounts()));
              }),
              drawerListTile(
                Icons.money_off,
                'Loans',
                () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoanMenu()));
                },
              ),
              drawerListTile(
                Icons.compare_arrows,
                'Cash Transfer',
                () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FundsTransfer()));
                },
              ),
              drawerListTile(
                Icons.check_circle_outline,
                'Guarantorship',
                () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Guarantorship()));
                },
              ),
              drawerListTile(
                Icons.attach_money,
                'Dividends',
                () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionHistory()));
                },
              ),
              drawerListTile(
                Icons.settings,
                'Settings',
                () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
              Divider(),
              drawerListTile(
                Icons.call,
                'Contact Us',
                () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
              drawerListTile(
                Icons.info_outline,
                'About App',
                () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
              drawerListTile(
                Icons.report,
                'Terms & Privacy Policy',
                () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
              Divider(),
              drawerListTile(
                Icons.exit_to_app,
                'Log Out',
                () {
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.menu,
                            size: 30,
                            color: Color(0xfff7f5fc),
                          ),
                          onPressed: () {
                            _drawerKey.currentState.openDrawer();
                          }),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: Color(0xfff7f5fc),
                          ),
                          onPressed: () {}),
                      dashBoardCards(Icon(Icons.account_circle), () {}),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      quickLinks(
                          Icon(
                            Icons.credit_card,
                            color: Colors.black,
                          ), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FundsTransfer()));
                      }, "Cash Transfer"),
                      quickLinks(Icon(Icons.money_off), () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoanMenu()));
                      }, "Loans"),
                      quickLinks(Icon(Icons.account_balance), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAccounts()));
                      }, "Accounts"),
                      quickLinks(Icon(Icons.monetization_on), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionHistory()));
                      }, "Dividends"),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 210, left: 5, right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "My Accounts",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        Spacer(),
                        Text(
                          "View all",
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton<String>(
                            onSelected: (String value) {
                              setState(() {});
                            },
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'Value1',
                                child: Text(
                                  'Account Statement',
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'Value2',
                                child: Text(
                                  'Account Transaction History',
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'Value3',
                                child: Text(
                                  'Cancel ATM Card',
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Current balance',
                                  style: Theme.of(context).textTheme.display1,
                                ),
                                Text(
                                  'Ksh. 100.00',
                                  style: Theme.of(context).textTheme.display4,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '**** **** **** 123',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Manjari',
                                  letterSpacing: 5),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "SAVINGS ACCOUNT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Manjari'),
                            )
                          ],
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    decoration: BoxDecoration(
                        color: Color(0xFF29304d),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Recent Transactions",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        Spacer(),
                        Text(
                          "View all",
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
