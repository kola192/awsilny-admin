import 'package:awsilny_admin/screens/home/drivers/driversList.dart';
import 'package:awsilny_admin/services/auth.dart';
import 'package:awsilny_admin/services/database.dart';
import 'package:awsilny_admin/shared/colors.dart';
import 'package:awsilny_admin/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Drivers extends StatefulWidget {
  const Drivers({Key? key}) : super(key: key);

  @override
  State<Drivers> createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  bool _showSheet = false;

  bool loading = false;

  final Database _database = Database();

  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  TextEditingController carTextEditingController = TextEditingController();

  String error = '';

  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showSheet
          ? null
          : AppBar(
              title: const Text('قائمة السائقين'),
              backgroundColor: AppColor.primaryColor,
            ),
      body: const DriversList(),
      bottomSheet: _showBottomSheet(),
      floatingActionButton: _showSheet
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _showSheet = true;
                });
              },
            ),
    );
  }

  Widget? _showBottomSheet() {
    if (_showSheet) {
      return SingleChildScrollView(
        child: BottomSheet(
          enableDrag: false,
          onClosing: () {},
          builder: (context) {
            return Container(
              // height: 500,
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text("x"),
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.pink,
                        ),
                        onPressed: () {
                          _showSheet = false;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Icon(
                    Icons.person,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'إضافة سائق',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'جميع الحقول مطلوبة';
                            }
                            return null;
                          }),
                          controller: nameTextEditingController,
                          keyboardType: TextInputType.text,
                          decoration:
                              inputDecoration.copyWith(labelText: 'الإسم'),
                          style: const TextStyle(
                              fontSize: 14.0, fontFamily: "Brand-Regular"),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'جميع الحقول مطلوبة';
                            }
                            return null;
                          }),
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: inputDecoration.copyWith(
                              labelText: 'البريد الإلكتروني'),
                          style: const TextStyle(
                              fontSize: 14.0, fontFamily: "Brand-Regular"),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'جميع الحقول مطلوبة';
                            }
                            return null;
                          }),
                          controller: phoneTextEditingController,
                          keyboardType: TextInputType.phone,
                          decoration: inputDecoration.copyWith(
                              labelText: 'رقم التلفون'),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'جميع الحقول مطلوبة';
                            }
                            return null;
                          }),
                          controller: carTextEditingController,
                          decoration: inputDecoration.copyWith(
                              labelText: 'نوع المركبة'),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'جميع الحقول مطلوبة';
                            }
                            return null;
                          }),
                          controller: passwordTextEditingController,
                          obscureText: true,
                          decoration: inputDecoration.copyWith(
                              labelText: 'كلمة المرور'),
                          style: const TextStyle(fontSize: 24.0),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColor.primaryColor,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34.0),
                            ),
                          ),
                          child: Container(
                            height: 50.0,
                            child: const Center(
                              child: Text(
                                "إضافة سائق",
                                style: TextStyle(
                                    fontSize: 18.0, fontFamily: "Brand Bold"),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              // create authentication user (email and password)
                              User newUser =
                                  await _auth.signUpWithEmailAndPassword(
                                      emailTextEditingController.text,
                                      passwordTextEditingController.text);

                              if (newUser == null) {
                                print('error signing in!');
                                setState(() {
                                  loading = false;
                                  passwordTextEditingController.text = '';
                                  error = 'خطأ في التسجيل';
                                });
                              } else {
                                // create user collection in the database (all user data)
                                _database.createNewDriver(
                                    newUser.uid,
                                    nameTextEditingController.text,
                                    emailTextEditingController.text,
                                    phoneTextEditingController.text,
                                    carTextEditingController.text);
                                // close bottomsheet
                                _showSheet = false;
                                nameTextEditingController.text = '';
                                emailTextEditingController.text = '';
                                phoneTextEditingController.text = '';
                                carTextEditingController.text = '';
                                passwordTextEditingController.text = '';
                                setState(() {});
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return null;
    }
  }
}
