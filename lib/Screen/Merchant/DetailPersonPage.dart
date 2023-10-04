// import 'package:flutter/material.dart';

// class DetailPersonPage extends StatefulWidget {
//   @override
//   State<DetailPersonPage> createState() => _DetailPersonPageState();
// }

// class _DetailPersonPageState extends State<DetailPersonPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.grey),
//         backgroundColor: Colors.grey[200],
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "Details",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Container(
//         color: Colors.blueGrey[100],
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 80,
//               ),
//               CircleAvatar(
//                 backgroundColor: Colors.white10,
//                 radius: 120,
//                 child: CircleAvatar(
//                   backgroundImage: AssetImage('assets/user_1.png'),
//                   radius: 100,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 "John Doe",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "29 years",
//                 style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "300m",
//                 style: const TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 208, 199, 199),
        height: 1000,
        // width: double.infinity,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                // height: 100,
                // width: 100,
                padding: EdgeInsets.all(15), // Padding for the border width
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                      255, 229, 223, 223), // Background color of the circle
                  borderRadius: BorderRadius.circular(
                      150), // Half of th e sum of radius and border width
                  border: Border.all(
                    color: Colors.transparent, // Border color
                    // width: 5, // Border width
                  ),
                ),
                child: CircleAvatar(
                  maxRadius: 100,
                  backgroundColor:
                      Colors.transparent, // Transparent background color
                  backgroundImage: AssetImage('assets/user_4.png'),
                  // You can set a background image or initials here if needed
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Graham Thorpe',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                '29 years',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              SizedBox(
                height: 14,
              ),
              Center(
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
              SizedBox(
                height: 105,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 4),
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
                      decoration: InputDecoration(
                        border: InputBorder.none, // Remove underline
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center, // Align text to the center
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      'US Dollars',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(
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
                    color: Color.fromARGB(255, 69, 190, 170),
                    child: Center(
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
