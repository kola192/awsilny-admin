import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  // final _database = FirebaseFirestore.instance;

  // users collection reference
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // create a new driver in the database
  void createNewDriver(id ,name, email, phone, carType) async {
    users.doc(id).set({
      'name': name,
      'email': email,
      'phone': phone,
      'carType': carType,
      'role': 'driver'
    }).then((value) {
      // print(value);
      print('driver added');
    }).catchError((err) => print(err.toString()));
  }
  // update driver
  void updateDriver(id, name, email, phone) async {
    users.doc(id).set({
      'name': name,
      'email': email,
      'phone': phone,
      'role': 'driver'
    }).then((value) {
      print('driver updated');
    }).catchError((err) => print(err.toString()));
  }

  // update driver
  void updateCustomer(id, name, email, phone) async {
    users.doc(id).set({
      'name': name,
      'email': email,
      'phone': phone,
      'role': 'customer'
    }).then((value) {
      print('customer updated');
    }).catchError((err) => print(err.toString()));
  }
}
