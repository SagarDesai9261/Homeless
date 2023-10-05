import 'package:flutter/material.dart';
import 'package:homeless/Screen/Merchant/EnteredOTPPage.dart';

class PersonDetailPage extends StatelessWidget {
  PersonDetailPage({Key? key}) : super(key: key);
  TextEditingController a = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 199, 199),
        height: 1000,
        // width: double.infinity,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                // height: 100,
                // width: 100,
                padding:
                    const EdgeInsets.all(15), // Padding for the border width
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 229, 223, 223), // Background color of the circle
                  borderRadius: BorderRadius.circular(
                      150), // Half of th e sum of radius and border width
                  border: Border.all(
                    color: Colors.transparent, // Border color
                    // width: 5, // Border width
                  ),
                ),
                child: const CircleAvatar(
                  maxRadius: 100,
                  backgroundColor:
                      Colors.transparent, // Transparent background color
                  backgroundImage: AssetImage('assets/user_4.png'),
                  // You can set a background image or initials here if needed
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                'Graham Thorpe',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                '29 years',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(
                height: 14,
              ),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_searching),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '300m away',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 105,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Amount',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  title: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.transparent), // Remove the border
                    ),
                    child: TextField(
                      controller: a,
                      decoration: const InputDecoration(
                        border: InputBorder.none, // Remove underline
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center, // Align text to the center
                    ),
                  ),
                  trailing: const Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      'US Dollars',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    color: const Color.fromARGB(255, 69, 190, 170),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Text(
                              'REQUEST PAYMENT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // child: ElevatedButton(
                    //   onPressed: () {
                    //     // Handle the donation button press
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(
                    //     //     builder: (context) => MyCustomLayout(),
                    //     //   ),
                    //     // );
                    //   },
                    //   child: Text('REQUEST PAYMENT'),
                    // ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
