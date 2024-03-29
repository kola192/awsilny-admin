import 'package:awsilny_admin/services/auth.dart';
import 'package:awsilny_admin/shared/loading.dart';
import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';

final AuthService _auth = AuthService();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  void signOutFunction() async {
    setState(() {
      loading = true;
    });
    final res = await _auth.signOut();
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text("لوحة التحكم"),
              backgroundColor: AppColor.primaryColor,
              elevation: 0.0,
              actions: <Widget>[
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.blueGrey[100],
                  ),
                  onPressed: signOutFunction,
                  icon: const Icon(Icons.logout),
                  label: Text('خروج',
                      style: TextStyle(color: AppColor.lightColor)),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(15.0),
              child: GridView.count(
                // crossAxisSpacing: 5,
                mainAxisSpacing: 2,
                crossAxisCount: 2,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: containerDecoration,
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/drivers');
                          },
                          icon: const Icon(Icons.person),
                          label: const Text('السائقين')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: containerDecoration,
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/customers');
                          },
                          icon: const Icon(Icons.person),
                          label: const Text('العملاء')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: containerDecoration,
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/bills');
                          },
                          icon: const Icon(Icons.person),
                          label: const Text('الفواتير')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: containerDecoration,
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/trips');
                          },
                          icon: const Icon(Icons.person),
                          label: const Text('الرحلات')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: containerDecoration,
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/orders');
                          },
                          icon: const Icon(Icons.person),
                          label: const Text('الحجوزات')),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}


          // ElevatedButton(
          //     onPressed: signOutFunction, child: const Text('Logout')),