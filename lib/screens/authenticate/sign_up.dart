import 'package:awsilny_admin/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import './sign_in.dart';

class RegisterationScreen extends StatefulWidget {
  static const String idScreen = "register";

  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  // TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  // TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 45.0,
              ),
              const Image(
                image: AssetImage("images/logo1.png"),
                width: 220.0,
                height: 220.0,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                " إنشاء حساب",
                style: TextStyle(fontSize: 30.0, fontFamily: "Brand-Regular"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5.0,
                    ),
                    // TextField(
                    //   controller: nameTextEditingController,
                    //   keyboardType: TextInputType.text,
                    //   decoration: const InputDecoration(
                    //     labelText: 'الأسم',
                    //     labelStyle: TextStyle(
                    //       fontSize: 20.0,
                    //     ),
                    //     hintStyle: TextStyle(
                    //         color: Colors.amberAccent, fontSize: 10.0),
                    //   ),
                    //   style: const TextStyle(
                    //       fontSize: 14.0, fontFamily: "Brand-Regular"),
                    // ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                              decoration: inputDecoration.copyWith(labelText: 'البريد الإلكتروني'),
                      style: const TextStyle(
                          fontSize: 14.0, fontFamily: "Brand-Regular"),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    // TextField(
                    //   controller: phoneTextEditingController,
                    //   keyboardType: TextInputType.phone,
                    //   decoration: const InputDecoration(
                    //     labelText: 'رقم التلفون',
                    //     labelStyle: TextStyle(
                    //       fontSize: 20.0,
                    //     ),
                    //     hintStyle: TextStyle(
                    //         color: Colors.amberAccent, fontSize: 50.0),
                    //   ),
                    //   style: const TextStyle(fontSize: 14.0),
                    // ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                              decoration: inputDecoration.copyWith(labelText: 'كلمة المرور'),
                      style: const TextStyle(fontSize: 24.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellowAccent,
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(34.0),
                        ),
                      ),
                      child: Container(
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            "إنشاء الحساب",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        print("sign up");
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailTextEditingController.text,
                                password: passwordTextEditingController.text);
                        setState(() {
                          
                        });
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, LoginScreen.idScreen, (route) => false);
                },
                child: const Text(
                  "اذا كنت تملك حساب مسيقا إضغط ل 'تسجيل الدخول'",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
