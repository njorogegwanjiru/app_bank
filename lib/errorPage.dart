import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  const ErrorPage({Key key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ERROR"),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: <Widget>[
            Text("Oops!"),
            Text(errorMessage)
          ],
        )),
      ),
    );
  }
}
