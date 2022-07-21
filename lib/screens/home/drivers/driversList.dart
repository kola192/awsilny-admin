import 'package:awsilny_admin/screens/home/drivers/singleDriver.dart';
import 'package:awsilny_admin/services/auth.dart';
import 'package:awsilny_admin/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DriversList extends StatefulWidget {
  const DriversList({Key? key}) : super(key: key);

  @override
  State<DriversList> createState() => _DriversListState();
}

class _DriversListState extends State<DriversList> {
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'driver')
      .snapshots();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey[50],
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleDriver(driver: data.docs[index]),
                              ),
                            );
                          },
                          leading: Text(data.docs[index]['name'], style: const TextStyle(fontSize: 18,),),
                          title: Text('${data.docs[index]['phone']}', style: const TextStyle(fontSize: 14,),),
                          trailing: TextButton.icon(
                            style: TextButton.styleFrom(
                              primary: Colors.pink,
                            ),
                            label: const Text(''),
                            onPressed: () {
                              _auth.deleteUser(data, index);
                              print('delete user');
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
