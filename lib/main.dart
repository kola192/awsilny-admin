
import 'package:awsilny_admin/screens/home/bills/bills.dart';
import 'package:awsilny_admin/screens/home/customers/customers.dart';
import 'package:awsilny_admin/screens/home/drivers/drivers.dart';
import 'package:awsilny_admin/screens/home/orders/orders.dart';
import 'package:awsilny_admin/screens/home/trips/trips.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:awsilny_admin/screens/wrapper.dart';
import 'package:awsilny_admin/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Awsilny Admin Dashboard',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE'), // English, no country code
        ],
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(context) => const Wrapper(),
          '/drivers':(context) => const Drivers(),
          '/customers': (context) => const Customers(),
          '/bills':(context) => const Bills(),
          '/trips':(context) => const Trips(),
          '/orders': (context) => const Orders(),
        },
        initialRoute: '/',
        // home: Wrapper(),
      ),
    );
  }
}
