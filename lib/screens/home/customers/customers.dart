import 'package:awsilny_admin/screens/home/customers/customersList.dart';
import 'package:awsilny_admin/shared/colors.dart';
import 'package:flutter/material.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: const Text('قائمة العملاء'),
              backgroundColor: AppColor.primaryColor,
            ),
      body: const CustomersList(),
    );
  }
}
