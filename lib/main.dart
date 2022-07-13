import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:awsilny_admin/screens/wrapper.dart';
import 'package:awsilny_admin/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDu3PisrA6RlbMpmKxiSb0z3oM_JDawAWY",
        authDomain: "awsilny-12c48.firebaseapp.com",
        projectId: "awsilny-12c48",
        storageBucket: "awsilny-12c48.appspot.com",
        messagingSenderId: "967758912691",
        appId: "1:967758912691:web:c4700cc12157735f3224c6"),
  );
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
      child: const MaterialApp(
        title: 'Awsilny Admin Dashboard',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'), // English, no country code
        ],
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
