import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeless/Screen/Merchant/DetailPersonPage.dart';
import 'package:homeless/Screen/Organization/AddMember.dart';
import 'package:homeless/Screen/Organization/EditMemberPage.dart';

class HomelessPeople extends StatefulWidget {
  @override
  State<HomelessPeople> createState() => _HomelessPeopleState();
}

class _HomelessPeopleState extends State<HomelessPeople> {
  @override
  void initState() {
    super.initState();
    filteredDetails = details;
  }

  int calculateAge(DateTime dob) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;

    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    return age;
  }

  List filteredDetails = [];
  List details = [
    {
      'index': 0,
      'profile': "assets/user_1.png",
      'name': "John Doe",
      'Near': "300m",
      'years': "28 Years"
    },
    {
      'index': 1,
      'profile': "assets/user_2.png",
      'name': "Alice Johnson",
      'Near': " 1.1m",
      'years': "32 Years"
    },
    {
      'index': 2,
      'profile': "assets/user_3.png",
      'name': "Madelyn Ekstrom",
      'Near': "300m",
      'years': "30 Years"
    },
    {
      'index': 3,
      'profile': "assets/user_4.png",
      'name': "Martin Levin",
      'Near': "1.3m",
      'years': "32 Years"
    },
    {
      'index': 4,
      'profile': "assets/user_5.png",
      'name': "Marley Geldt",
      'Near': "1.8m",
      'years': "32 Years"
    },
    {
      'index': 5,
      'profile': "assets/user_6.png",
      'name': "Mira Lubin",
      'Near': "300m",
      'years': "32 Years"
    },
  ];

  Widget appBarTitle = const Row(
    children: [
      Icon(
        Icons.location_on,
        size: 28,
        color: Colors.grey,
      ),
      Text(
        "HOME",
        style: TextStyle(color: Colors.black),
      ),
      Text(
        "LESS",
        style: TextStyle(color: Colors.grey),
      ),
    ],
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.black,
  );
  @override
  Widget build(BuildContext context) {
    // Get the screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the desired number of columns based on screen width
    int crossAxisCount = (screenWidth / 150).floor(); // Adjust 150 as needed

    // Calculate the child aspect ratio based on the number of columns
    double childAspectRatio = screenWidth / 375.0 * 0.75;

    // Get the screen height using MediaQuery

    // Adjust the fraction as needed

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white60,
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (actionIcon.icon == Icons.search) {
                    actionIcon = const Icon(Icons.close, color: Colors.black);
                    appBarTitle = const TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.black)),
                    );
                  } else {
                    actionIcon = const Icon(Icons.search, color: Colors.black);
                    appBarTitle = const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 28,
                          color: Colors.grey,
                        ),
                        Text(
                          "HOME",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "LESS",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    );
                  }
                });
              },
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddMemberPage()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('HomeLessMembers')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No data available');
          }

          List<DocumentSnapshot> userProfiles = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount, // Two cards per row
              childAspectRatio:
                  childAspectRatio, // Aspect ratio of the cards (square)
            ),
            itemCount: userProfiles.length,
            itemBuilder: (BuildContext context, int index) {
              // int monthNumber =
              //     getMonthNumber(userProfiles[index]['monthOfBirth']);

              // DateTime date = DateTime(
              //     int.parse(userProfiles[index]['yearOfBirth']),
              //     monthNumber,
              //     int.parse(userProfiles[index]['dayOfBirth']));
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditMemberPage(
                              memberId: userProfiles[index].id)));
                },
                child: Card(
                  // shape:
                  //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  //elevation: 2.0, // Card elevation
                  //margin: EdgeInsets.all(10.0), // Margin around each card
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 150,
                            child: Image.network(
                                userProfiles[index]['profileImageUrl']),
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 21),
                            child: Text(
                              '${userProfiles[index]['fullName']}',
                              style: const TextStyle(
                                color: Color(0xFF1F2D36),
                                fontSize: 18,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w500,
                                height: 0.07,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                            ),
                            child: Container(
                              width: 70,
                              height: 30,
                              child: Text(
                                "${calculateAge(DateTime.parse(userProfiles[index]['dob'])).toString()} Years",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  int getMonthNumber(String monthName) {
    // Define a map to map month names to their numeric values
    final months = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12,
    };

    // Convert the month name to a numeric value
    return months[monthName] ?? 1; // Default to January if not found
  }
}
