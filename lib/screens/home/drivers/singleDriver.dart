import 'package:awsilny_admin/services/database.dart';
import 'package:awsilny_admin/shared/constants.dart';
import 'package:awsilny_admin/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleDriver extends StatefulWidget {
  const SingleDriver({
    Key? key,
    this.driver
  }) : super(key: key);

  final driver;

  @override
  State<SingleDriver> createState() => _SingleDriverState();
}

class _SingleDriverState extends State<SingleDriver> {
  bool _showSheet = false;

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> users = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'driver')
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: users,
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.hasError) {
              return const Text('Some error happend !!!');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }

            final data = snapshot.requireData;
            return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return widget.driver['email'] == data.docs[index]['email']
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              data.docs[index]['name'],
                              style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                              width: 200,
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            InfoCard(
                                text: data.docs[index]['phone'],
                                icon: Icons.phone,
                                onPressed: () {
                                  print("this is your phone");
                                }),
                            InfoCard(
                                text: data.docs[index]['email'],
                                icon: Icons.email,
                                onPressed: () {
                                  print("this is your Emaile");
                                }),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Card(
                                color: Colors.grey[800],
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 115.0),
                                child: const ListTile(
                                  leading: Icon(
                                    Icons.follow_the_signs,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    "رجوع",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : const Text('');
                });
          },
        ),
      ),
      bottomSheet: _showBottomSheet(),
      floatingActionButton: _showSheet
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.grey[700],
              onPressed: () {
                setState(() {
                  _showSheet = true;
                });
              },
              child: const Icon(Icons.edit),
            ),
    );
  }

  Widget? _showBottomSheet() {

    final Stream<QuerySnapshot> users = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'customer')
        .snapshots();

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    Database database = Database();

    if (_showSheet) {
      return BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) {
          final formKey = GlobalKey<FormState>();
          return StreamBuilder<QuerySnapshot>(
            stream: users,
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (snapshot.hasError) {
                return const Text('Some error happend !!!');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              }

              final data = snapshot.requireData;
              return ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    if (widget.driver == data.docs[index].id) {
                      nameController.text = data.docs[index]['name'];
                      emailController.text = data.docs[index]['email'];
                      phoneController.text = data.docs[index]['phone'];

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
                              'تعديل الملف الشخصي',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24.0),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: TextFormField(
                                        controller: nameController,
                                        decoration: inputDecoration.copyWith(
                                            labelText: 'الإسم'),
                                        validator: ((value) {
                                          if (value == null || value.isEmpty) {
                                            return 'جميع الحقول مطلوبة';
                                          }
                                          return null;
                                        }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: TextFormField(
                                        controller: emailController,
                                        decoration: inputDecoration.copyWith(
                                            labelText: 'البريد الإلكتروني'),
                                        validator: ((value) {
                                          if (value == null || value.isEmpty) {
                                            return 'جميع الحقول مطلوبة';
                                          }
                                          return null;
                                        }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: TextFormField(
                                        controller: phoneController,
                                        decoration: inputDecoration.copyWith(
                                            labelText: 'رقم النلفون'),
                                        validator: ((value) {
                                          if (value == null || value.isEmpty) {
                                            return 'جميع الحقول مطلوبة';
                                          }
                                          return null;
                                        }),
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue[900],
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(34.0),
                                ),
                              ),
                              // color: Colors.yellowAccent,
                              // textColor: Colors.black,
                              child: Container(
                                height: 50.0,
                                child: const Center(
                                  child: Text(
                                    "تعديل",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "Brand Bold"),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  database.updateDriver(
                                      data.docs[index].id,
                                      nameController.text,
                                      emailController.text,
                                      phoneController.text);
                                  _showSheet = false;
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text('');
                    }
                  });
            },
          );
        },
      );
    } else {
      return null;
    }
  }
}

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;

  InfoCard({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.yellow,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black87,
          ),
          title: Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}