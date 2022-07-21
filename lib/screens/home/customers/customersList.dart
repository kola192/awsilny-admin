import 'package:awsilny_admin/screens/home/customers/singleCustomer.dart';
import 'package:awsilny_admin/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomersList extends StatefulWidget {
  const CustomersList({Key? key}) : super(key: key);

  @override
  State<CustomersList> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'customer')
      .snapshots();


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
                                builder: (context) => SingleCustomer(customer: data.docs[index]),
                              ),
                            );
                          },
                          leading: Text(data.docs[index]['name']),
                          trailing: Text('${data.docs[index]['phone']}'),
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
