import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String username;
  String idNumber;
  String mobileNumber;
  String fullNames;

  User(this.username, this.idNumber, this.mobileNumber, this.fullNames);

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.value["Uid"],
        username = snapshot.value["username"],
        idNumber = snapshot.value["idNumber"],
        mobileNumber = snapshot.value["MobileNumber"],
        fullNames = snapshot.value["Names"];

  toJson() {
    return {
      "username": username,
      "idNumber": idNumber,
      "MobileNumber": mobileNumber,
      "Names": fullNames,
    };
  }
}
