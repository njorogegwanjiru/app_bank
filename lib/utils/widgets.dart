import 'package:flutter/material.dart';
import 'package:app_bank/model/countries.dart';

class Widgets {
  static Widget getLogo({String logoPath, double height}) =>
      Material(
        type: MaterialType.transparency,
        elevation: 10.0,
        child: Image.asset(logoPath, height: height),
      );

  static Widget searchCountry(TextEditingController controller) =>
      Padding(
        padding:
        const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 2.0, right: 8.0),
        child: Card(
          child: TextFormField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
                hintText: 'Search your country',
                contentPadding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                border: InputBorder.none),
          ),
        ),
      );

  static Widget phoneNumberField(TextEditingController controller,
      String prefix, style, textStyle) =>
      Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.black)),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Text(
              "  " + prefix + "  ",
              style: style,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Container(
                width: 1,
                height: 30,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: TextField(
                style: textStyle,
                controller: controller,
                autofocus: false,
                keyboardType: TextInputType.phone,
                key: Key('EnterPhone-TextFormField'),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 2.0, bottom: 2.0),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  static Widget selectableWidget(Country country,
      Function(Country) selectThisCountry) =>
      Material(
        color: Colors.white,
        type: MaterialType.canvas,
        child: InkWell(
          onTap: () => selectThisCountry(country), //selectThisCountry(country),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
            child: Text(
              "  " +
                  country.flag +
                  "  " +
                  country.name +
                  " (" +
                  country.dialCode +
                  ")",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );

  static Widget selectCountryDropDown(Country country, Function onPressed,
      style) =>
      Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.black)),
        color: Colors.white,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 4.0, top: 8.0, bottom: 8.0),
            child: Row(
              children: <Widget>[
                Text('${country.flag}'),
                Icon(
                  Icons.arrow_drop_down,
                  size: 24.0,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12, left: 8),
                  child: Container(
                    width: 1,
                    height: 30,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                    child: Text(
                      "${country.name}",
                      style: style,
                    )),
              ],
            ),
          ),
        ),
      );

  static Widget subTitle(String text) =>
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ' $text',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ));
}

Widget getTextFormField(_controller, _labelText, _validatorMessage,
    TextInputType keyboardType) {
  var field = Padding(
    padding: const EdgeInsets.all(5),
    child: new TextFormField(
      keyboardType: keyboardType,
      controller: _controller,
      decoration: InputDecoration(labelText: _labelText),
      validator: (value) {
        if (value.isEmpty) {
          return _validatorMessage;
        }
        return null;
      },
    ),
  );
  return field;
}

Widget getOutlineButton(String buttonLabel, onClick, TextStyle style) {
  var _outlineButton = new InkWell(
    onTap: onClick,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      padding: EdgeInsets.symmetric(vertical: 12),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
      ),
      child: new Text(buttonLabel, style: style),
    ),
  );
  return _outlineButton;
}

Widget smallContainer(innerChild) {
  var _container = new Container(
    height: 50,
    width: 50,
    child: innerChild,
  );
  return _container;
}

Widget dashBoardCards(Widget child, Function onTap) {
  var _card = smallContainer(Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13),
      side: BorderSide(color: Colors.white70),
    ),
    child: new InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: child,
      ),
    ),
  ));
  return _card;
}

Widget labelText(text) {
  var _text = new Text(text,
      style: TextStyle(
        color: Color(0xfff7f5fc),
        fontSize: 16.0,
      ));
  return _text;
}

Widget menuCard(IconData icon) {
return Card(
  child: Container(
    height: 50,
    width: 50,
    child: Icon(
      icon,
      color: Colors.white,
    ),
  ),
  color: Color(0xFF29304d),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(13),
  ),
);
}

Widget quickLinks(Widget child, Function onTap, label) {
  var _quickLink = Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      smallContainer(Card(
        color: Color(0xfff7f5fc),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: new InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: child,
          ),
        ),
      )),
      SizedBox(
        height: 10,
      ),
      labelText(label)
    ],
  );
  return _quickLink;
}
