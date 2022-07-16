import 'package:awsilny_admin/shared/colors.dart';
import 'package:flutter/material.dart';

class Customers extends StatelessWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
      ),
      body: const Center(child: Text("customers")),
    );
  }
}
