import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:homeless/Screen/Register_merchant.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import 'home_screen.dart';

class Login_screen_Merchant extends StatefulWidget {
  const Login_screen_Merchant({Key? key}) : super(key: key);

  @override
  State<Login_screen_Merchant> createState() => _Login_screen_MerchantState();
}

class _Login_screen_MerchantState extends State<Login_screen_Merchant> {
  String error = "";
  bool pass = true;
  bool isloading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: form_key,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFF46BA80),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "Welcome to Merchant",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .75,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(100))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .1,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                  hintText: "Email address",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                      //borderSide: BorderSide.none
                                      )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: TextFormField(
                              controller: password,
                              obscureText: pass,
                              decoration: InputDecoration(
                                  suffixIcon: pass
                                      ? IconButton(
                                          icon: const Icon(Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              pass = false;
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: const Icon(Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              pass = true;
                                            });
                                          },
                                        ),
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                      //borderSide: BorderSide.none
                                      )),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showAlertDialog(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * .15),
                              alignment: Alignment.topRight,
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Color(0xFF46BA80),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text);
                                setState(() {
                                  error = "";
                                });
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  error = "Email and Password are not valid";
                                });
                              }

                              setState(() {
                                isloading = true;
                              });

                              // Simulate a login request.
                              await Future.delayed(const Duration(seconds: 3));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Navbar_screen()));
                              setState(() {
                                isloading = false;
                              });
                              if (error != "") {
                                Alert(
                                        context: context,
                                        type: AlertType.error,
                                        title: error.toString())
                                    .show();
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Navbar_screen()));
                              }
                            },
                            child: Container(
                                width: 200,
                                height: 50,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF46BA80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: isloading == false
                                    ? const Text('Sign to your Account',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'SF Pro Text',
                                          fontWeight: FontWeight.w600,
                                          height: 2,
                                        ))
                                    : const Center(
                                        child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have Account ? ",
                                style: TextStyle(fontSize: 16),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Register_merchant()));
                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF46BA80)),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    TextEditingController _emailController = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final emailField = TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
              hintText: 'something@example.com',
              // labelText: 'Account Email to Reset',
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
              hintStyle: const TextStyle(
                color: Colors.black,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        );

        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: MediaQuery.of(context).size.height / 4,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xFFFFFF),
              borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Reset Password Link",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                emailField,
                MaterialButton(
                  onPressed: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _emailController.text);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 12,
                    padding: const EdgeInsets.all(15.0),
                    child: Material(
                        color: const Color(0xFF46BA80),
                        borderRadius: BorderRadius.circular(25.0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Reset',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'helvetica_neue_light',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
