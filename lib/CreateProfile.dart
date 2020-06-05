import 'dart:io';

import 'package:app_bank/utils/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/Dashboard.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  File _image;

  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final idController = TextEditingController();
  final pin1Controller = TextEditingController();
  final pin2Controller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _agreedToTOS = true;
  bool _loading = false;

  final _database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = 'img' + (_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: new SizedBox(
                                width: 100.0,
                                height: 100.0,
                                child: (_image != null)
                                    ? Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      )
                                    : Icon(Icons.person, size: 80,color: Theme.of(context).colorScheme.surface,),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 70, left: 90),
                              child: Icon(
                                Icons.camera_enhance,size: 30,
                                color: Theme.of(context).colorScheme.surface,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            getTextFormField(usernameController, "Username",
                                "Username Required", TextInputType.text),
                            getTextFormField(idController, "ID Number",
                                "ID Required", TextInputType.number),
                            getTextFormField(pin1Controller, "Set Pin",
                                "Pin Required", TextInputType.number),
                            getTextFormField(pin2Controller, "Confirm Pin",
                                "Confirmation Required", TextInputType.number),
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
                            Padding(
                                padding: EdgeInsets.all(5),
                                child: _loading
                                    ? CircularProgressIndicator()
                                    : getOutlineButton(
                                        "SUBMIT",
                                        (_submittable()
                                            ? () {
                                                _submit();
                                                uploadPic(context);
                                              }
                                            : null),
                                        Theme.of(context).textTheme.subtitle)),
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
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      _updateUser();
    }
  }

  _updateUser() async {
    await _database
        .reference()
        .child("Members")
        .child("MemberIdNo")
        .child(idController.text)
        .update({
      "UserName": usernameController.text,
      "Pin": pin1Controller.text
    }).then((_) {
      setState(() {
        _loading = false;
      });
      final snackBar = (SnackBar(content: Text('Successfully Added')));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashBoard()));
    }).catchError((onError) {
      final errSnackBar = (SnackBar(content: Text(onError.toString())));
      _scaffoldKey.currentState.showSnackBar(errSnackBar);
    });

    idController.clear();
    usernameController.clear();
    pin1Controller.clear();
    pin2Controller.clear();
  }
}
