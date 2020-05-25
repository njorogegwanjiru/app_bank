import 'package:app_bank/Dashboard.dart';
import 'package:app_bank/auth/auth.dart';
import 'package:app_bank/userAPI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'model/user.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  FirebaseUser fuser;
  TextEditingController usernameController, idController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text('Create Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 150,
          margin: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Card(
              color: Theme.of(context).cardTheme.color,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },

                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: idController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'ID Number',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'ID Number is required';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _agreedToTOS,
                                  onChanged: _setAgreedToTOS,
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () => _setAgreedToTOS(!_agreedToTOS),
                                    child: const Text(
                                      'I agree to the Terms of Services and Privacy Policy',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Spacer(),
                              OutlineButton(
                                highlightedBorderColor: Colors.black,
                                onPressed: _submittable() ? _submit : null,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: Text(
                                    'Register',
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _updateUser(User(usernameController.text, idController.text, "", "" ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashBoard()));
      print('Form submitted');
    }
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }

  _updateUser(User user) {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      fuser = user;
    });
    if (user != null) {
      _database
          .reference()
          .child("Members")
          .child("MemberIdNo")
          .child(fuser.uid)
          .update({
        "username": user.username,
        "idNumber": user.idNumber,
      });
    }
  }
}
