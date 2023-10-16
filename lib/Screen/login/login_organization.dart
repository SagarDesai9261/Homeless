import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeless/Screen/register/Register.dart';
import 'package:homeless/model/service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Organization/home_screen.dart';

class Login_screen_Organazition extends StatefulWidget {
  const Login_screen_Organazition({Key? key}) : super(key: key);

  @override
  State<Login_screen_Organazition> createState() =>
      _Login_screen_OrganazitionState();
}

class _Login_screen_OrganazitionState extends State<Login_screen_Organazition> {
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
                      "Welcome to Organization",
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null; // Return null if the input is valid.
                              },
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
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please enter Choose Password";
                                } else if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
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
                                          icon:
                                              const Icon(Icons.visibility_off),
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
                              if (form_key.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);
                                  final user =
                                      FirebaseAuth.instance.currentUser;

                                  if (user!.displayName == "Organization") {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Navbar_screen()));
                                    // ignore: use_build_context_synchronously
                                    showalert("Login Successfully",
                                        AlertType.success, context);
                                  } else {
                                    FirebaseAuth.instance.signOut();
                                    // ignore: use_build_context_synchronously
                                    showalert(
                                        "Email is not register in Organization",
                                        AlertType.error,
                                        context);
                                  }
                                  //print(user!.displayName);
                                  setState(() {
                                    isloading = false;
                                  });
                                } catch (e) {
                                  if (e is FirebaseAuthException) {
                                    print(
                                        'Firebase Authentication Error: ${e.code}');
                                    print('Error Message: ${e.message}');
                                    if (e.code == "INVALID_LOGIN_CREDENTIALS") {
                                      print("hello");
                                    }
                                    switch (e.code) {
                                      case 'INVALID_LOGIN_CREDENTIALS':
                                        // ignore: use_build_context_synchronously
                                        showalert(
                                            "Your Email and Password is invalid",
                                            AlertType.error,
                                            context);
                                        isloading == false;
                                        break;
                                      case 'invalid-email':
                                        // ignore: use_build_context_synchronously
                                        showalert("Your Email is invalid",
                                            AlertType.error, context);
                                        isloading == false;
                                        // Handle invalid email error
                                        break;
                                      case 'user-disabled':
                                        // ignore: use_build_context_synchronously
                                        showalert(
                                            e.code, AlertType.error, context);
                                        // Handle user disabled error
                                        break;
                                      case 'user-not-found':
                                        // ignore: use_build_context_synchronously
                                        showalert("Email is not Register",
                                            AlertType.error, context);
                                        isloading == false;
                                        // Handle user not found error
                                        break;
                                      case 'wrong-password':
                                        // ignore: use_build_context_synchronously
                                        showalert("Password is mismatch",
                                            AlertType.error, context);
                                        isloading == false;
                                        // Handle wrong password error
                                        break;
                                      case 'too-many-requests':
                                        // Handle too many login attempts error
                                        break;
                                      case 'network-request-failed':
                                        // Handle network request failed error
                                        break;
                                      default:
                                        // Handle other Firebase Authentication errors
                                        break;
                                    }
                                  }
                                }

/*
                              // Simulate a login request.
                              await Future.delayed(Duration(seconds: 3));
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
                              */
                                /*  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Navbar_screen()));*/ /*
                              }*/
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
                                    ? const Text('Sign up your Account',
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
                                                Register_Organization()));
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

  showalert(message, type, BuildContext context) {
    return Alert(
      context: context,
      title: message,
      type: type,
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              isloading = false;
            });
          },
          width: 120,
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  showAlertDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final emailField = TextFormField(
          controller: emailController,
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
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            child: Column(
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
                        .sendPasswordResetEmail(email: emailController.text)
                        .then((value) {
                      Navigator.pop(context);
                      Alert(
                          context: context,
                          title: "Reset Password sent Successfully",
                          type: AlertType.success,
                          buttons: [
                            DialogButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  Alert(context: context).dismiss();
                                  Navigator.pop(context);
                                })
                          ]).show();
                    });
                    //  Navigator.of(context).pop();
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
