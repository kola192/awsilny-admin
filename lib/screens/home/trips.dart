import 'package:awsilny_admin/shared/colors.dart';
import 'package:flutter/material.dart';

class Trips extends StatelessWidget {
  const Trips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
      ),
      body: const Center(child: Text("trips")),
    );
  }
}
