import 'package:awsilny_admin/screens/home/trips/tripsList.dart';
import 'package:awsilny_admin/shared/colors.dart';
import 'package:flutter/material.dart';

class Trips extends StatefulWidget {
  const Trips({Key? key}) : super(key: key);

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: const Text('قائمة الرحلات'),
              backgroundColor: AppColor.primaryColor,
            ),
      body: const TripsList(),
    );
  }
}
