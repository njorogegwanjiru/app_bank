import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';

class NewProfile extends StatefulWidget {
  @override
  _NewProfileState createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final idController = TextEditingController();
  final pin1Controller = TextEditingController();
  final pin2Controller = TextEditingController();

  bool _agreedToTOS = true;

  final _database = FirebaseDatabase.instance;

  Widget getTextFormField(_controller, _labelText, _validatorMessage) {
    var field = Padding(
      padding: const EdgeInsets.all(5),
      child: new TextFormField(
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

  Widget getOutlineButton(String buttonLabel, onClick) {
    var _outlineButton = new InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(8.0),
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
        ),
        child:
            new Text(buttonLabel, style: Theme.of(context).textTheme.subtitle),
      ),
    );
    return _outlineButton;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text('Create Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: (BorderRadius.circular(50)),
                ),
                child: Image(
                  image: AssetImage(
                    'assets/images/flake.png',
                  ),
                  height: 50.0,
                  width: 50.0,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: Theme.of(context).cardTheme.color,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  getTextFormField(usernameController, "Username",
                                      "Username Required"),
                                  getTextFormField(
                                      idController, "ID Number", "ID Required"),
                                  getTextFormField(
                                      pin1Controller, "Set Pin", "Pin Required"),
                                  getTextFormField(pin2Controller, "Confirm Pin",
                                      "Confirmation Required"),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                          value: _agreedToTOS,
                                          onChanged: _setAgreedToTOS,
                                        ),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () =>
                                                _setAgreedToTOS(!_agreedToTOS),
                                            child: const Text(
                                              'I agree to the Terms of Services and Privacy Policy',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  getOutlineButton(
                                      "SUBMIT",
                                      (_submittable()
                                          ? () {
                                              _submit();
                                            }
                                          : null))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  _submit() {
    _updateUser();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashBoard()));
  }

  _updateUser() async {
    _database
        .reference()
        .child("Members")
        .child("MemberIdNo")
        .child(idController.text)
        .update(
            {"UserName": usernameController.text, "Pin": pin1Controller.text});

    idController.clear();
    usernameController.clear();
    pin1Controller.clear();
  }
}
