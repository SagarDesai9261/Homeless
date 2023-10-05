import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneratePinPage extends StatefulWidget {
  @override
  State<GeneratePinPage> createState() => _GeneratePinPageState();
}

class _GeneratePinPageState extends State<GeneratePinPage> {
  // ignore: non_constant_identifier_names
  String Value = '';

  @override
  void initState() {
    super.initState();
    // Call the generateRandomString function here to initialize Value

    _loadValue();
  }

  _saveValue(String value) async {
    if (value != null || value != '') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('pin_value', value);
    }
  }

  // Method to retrieve Value from shared preferences
  _loadValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedValue = prefs.getString('pin_value') ?? '';
    setState(() {
      Value = savedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(Value);
    Value = Value != "" ? Value : generateRandomString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        title: Text(
          'Pay',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              color: Colors.grey, onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                'Share your unique pin with merchant\n \t\t\t\t\t\t\t\t\t\t\tto complete transaction',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
            //
            Container(
                padding: EdgeInsets.all(40), //padding of outer Container
                child: DottedBorder(
                  color: Colors.black, //color of dotted/dash line
                  strokeWidth: 3, //thickness of dash/dots
                  dashPattern: [10, 6],
                  //dash patterns, 10 is dash width, 6 is space width
                  child: Container(
                    //inner container
                    height: 80, //height of inner container
                    width: double
                        .infinity, //width to 100% match to parent container.
                    color: Colors.white, //background color of inner container
                    child: Center(
                        child: Text(
                      Value,
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    )),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                'You are paying USD 20 to 7-Eleven',
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          // color: Colors.amber,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your Available Wallet Balance is USD 49.40',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ),
            ],
          )),
    );
  }

  String generateRandomString() {
    final random = Random();
    final alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final digits = '0123456789';

    String result = '';

    // Generate 3 random alphabets
    for (int i = 0; i < 3; i++) {
      final randomIndex = random.nextInt(alphabet.length);
      result += alphabet[randomIndex];
    }

    // Generate 2 random digits
    for (int i = 0; i < 2; i++) {
      final randomIndex = random.nextInt(digits.length);
      result += digits[randomIndex];
    }

    // Generate 1 random alphabet
    final randomIndex = random.nextInt(alphabet.length);
    result += alphabet[randomIndex];
    _saveValue(result);
    return result;
  }
}
