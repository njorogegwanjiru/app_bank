import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Current balance',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontFamily: 'Manjari',
                      ),
                    ),
                    Text(
                      'Ksh. xxx',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontFamily: 'Manjari',
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '12345678',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Manjari',
                      letterSpacing: 5),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Shares Account",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: 'Manjari'),
                )
              ],
            ),
          ],
        ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          color: Color(0xFF29304d), borderRadius: BorderRadius.circular(15)),
    );
  }
}
