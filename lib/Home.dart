import 'package:app_bank/utils/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).colorScheme.surface,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "12,000.00",
                      style: Theme.of(context).textTheme.display4,
                    ),
                    Spacer(),
                    IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
                    dashBoardCards(Icon(Icons.account_circle), () {}),
                  ],
                ),
                labelText("Available Balance"),
                Row(
                  children: <Widget>[
                    quickLinks(Icon(Icons.credit_card), () {}, "Send"),
                    quickLinks(Icon(Icons.credit_card), () {}, "Request"),
                    quickLinks(
                        Icon(Icons.settings_backup_restore), () {}, "History"),
                    quickLinks(Icon(Icons.account_balance), () {}, "Accounts"),
                  ],
                ),
                Card(
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.white70),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Your Cards", style: Theme.of(context).textTheme.subtitle,),
                            Spacer(),
                            Text("View all", style: Theme.of(context).textTheme.subhead,),
                          ],
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
