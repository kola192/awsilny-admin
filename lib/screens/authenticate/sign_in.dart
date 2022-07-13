import 'package:awsilny_admin/services/auth.dart';
import 'package:awsilny_admin/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const String idScreen = "Login";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 65.0,
                      ),
                      const Image(
                        image: AssetImage("images/logo_blue.png"),
                        width: 380.0,
                        height: 250.0,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Text(
                        "تسجيل الدخول",
                        style:
                            TextStyle(fontSize: 30.0, fontFamily: "Brand Bold"),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextFormField(
                              validator: ((value) {
                                if (value == null || value.isEmpty) {
                                  return 'جميع الحقول مطلوبة';
                                }
                                return null;
                              }),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'البريد الألكتروني',
                                labelStyle: TextStyle(
                                  fontSize: 20.0,
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.amberAccent, fontSize: 10.0),
                              ),
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextFormField(
                              validator: ((value) {
                                if (value == null || value.isEmpty) {
                                  return 'جميع الحقول مطلوبة';
                                }
                                return null;
                              }),
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "كلمة السر",
                                labelStyle: TextStyle(
                                  fontSize: 20.0,
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.amberAccent, fontSize: 10.0),
                              ),
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              error,
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue[900],
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(34.0),
                                ),
                              ),
                              // color: Colors.yellowAccent,
                              // textColor: Colors.black,
                              child: Container(
                                height: 50.0,
                                child: const Center(
                                  child: Text(
                                    "تسجيل الدخول",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "Brand Bold"),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _auth.signIn(
                                      emailController.text,
                                      passwordController.text);
                                  if (result == null) {
                                    print('error signing in!');
                                    setState(() {
                                      emailController.text = '';
                                      passwordController.text = '';
                                      error = 'بيانات الدخول غير صحيحة';
                                    });
                                  } else {
                                    print('signed in');
                                    print(result.uid);
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
