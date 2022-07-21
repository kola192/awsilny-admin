import 'package:awsilny_admin/screens/home/customers/singleCustomer.dart';
import 'package:awsilny_admin/shared/colors.dart';
import 'package:awsilny_admin/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SingleOrder extends StatefulWidget {
  const SingleOrder({Key? key, this.order}) : super(key: key);

  final order;
  @override
  State<SingleOrder> createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: AppColor.primaryColor,
      ),
      backgroundColor: AppColor.primaryColor,
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
                  return widget.order['customerID'] == data.docs[index].id
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'بيانات الرحلة',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black87,
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
                                text:
                                    ' صاحب الرحلة : ${data.docs[index]['name']}',
                                icon: Icons.person,
                                onPressed: () {
                                  print("this is your phone");
                                }),
                            InfoCard(
                                text:
                                    ' نقطة الإنطلاق : ${widget.order['startPlace']}',
                                icon: Icons.home,
                                onPressed: () {
                                  print("this is your Emaile");
                                }),
                            InfoCard(
                                text:
                                    ' نقطة الوصول : ${widget.order['arrivePlace']}',
                                icon: Icons.map,
                                onPressed: () {
                                  print("this is your Emaile");
                                }),
                            InfoCard(
                                text: ' السعر : ${widget.order['price']}',
                                icon: Icons.money,
                                onPressed: () {
                                  print("this is your Emaile");
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : const Text('');
                });
          },
        ),
      ),
    );
  }
}
