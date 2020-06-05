import 'package:app_bank/CreateProfile.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        children: <Widget>[
          Card(
            elevation: 10,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateProfile()));
              },
              isThreeLine: true,
              leading: Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: Icon(
                    Icons.attach_money,
                  ),
                ),
              ),
              title: Text(
                'PROFILE SETTINGS',
                style: Theme.of(context).textTheme.body1,
              ),
              subtitle: Text(
                'Set up/ edit profile',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateProfile()));
              },
              isThreeLine: true,
              leading: Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: Icon(
                    Icons.attach_money,
                  ),
                ),
              ),
              title: Text(
                'PASSWORD',
                style: Theme.of(context).textTheme.body1,
              ),
              subtitle: Text(
                'Change/reset password',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



