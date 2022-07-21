import 'package:awsilny_admin/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TripsList extends StatefulWidget {
  const TripsList({Key? key}) : super(key: key);

  @override
  State<TripsList> createState() => _TripsListState();
}

class _TripsListState extends State<TripsList> {
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection('trips').where('status', isEqualTo: 'accepted')
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
                          leading: Text('من ${data.docs[index]['startPlace']}'),
                          title: Text('إلى ${data.docs[index]['arrivePlace']}'),
                          trailing: Text('\$${data.docs[index]['price']}'),
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
