import 'package:awsilny_admin/screens/home/bills/billsList.dart';
import 'package:awsilny_admin/shared/colors.dart';
import 'package:flutter/material.dart';

class Bills extends StatefulWidget {
  const Bills({Key? key}) : super(key: key);

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: const Text('قائمة الفواتير'),
              backgroundColor: AppColor.primaryColor,
            ),
      body: const BillsList(),
    );
  }
}
