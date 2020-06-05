import 'package:flutter/material.dart';
class MyAccounts extends StatefulWidget {
  @override
  _MyAccountsState createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'My Cards',
          style: Theme.of(context).appBarTheme.textTheme.display2,
        ),
      ),
    );
  }
}
