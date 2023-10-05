import 'package:flutter/material.dart';
import 'package:homeless/Screen/Merchant/DetailPersonPage.dart';

class Merchant_dashboard extends StatefulWidget {
  @override
  State<Merchant_dashboard> createState() => _Merchant_dashboardState();
}

class _Merchant_dashboardState extends State<Merchant_dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredDetails = details;
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

  Widget appBarTitle = new Row(
    children: [
      const Icon(
        Icons.location_on,
        size: 28,
        color: Colors.grey,
      ),
      const Text(
        "HOME",
        style: TextStyle(color: Colors.black),
      ),
      const Text(
        "LESS",
        style: TextStyle(color: Colors.grey),
      ),
    ],
  );
  Icon actionIcon = new Icon(
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
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust the fraction as needed

    return Scaffold(
      // appBar: AppBar(
      // backgroundColor: Colors.white60,
      // title: Row(
      //   children: [
      //     Icon(
      //       Icons.location_on,
      //       size: 28,
      //       color: Colors.grey,
      //     ),
      //     Text(
      //       "HOME",
      //       style: TextStyle(color: Colors.black),
      //     ),
      //     Text(
      //       "LESS",
      //       style: TextStyle(color: Colors.grey),
      //     ),
      //   ],
      // ),
      //   actions: [
      //     IconButton(
      //       iconSize: 28,
      //       color: Colors.grey,
      //       onPressed: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => SearchPageMerchant()));
      //       },
      //       icon: Icon(Icons.search),
      //     ),
      //     IconButton(
      //       iconSize: 28,
      //       color: Colors.grey,
      //       onPressed: () {},
      //       icon: Icon(Icons.menu),
      //     ),
      //   ],
      // ),
      appBar: AppBar(
          backgroundColor: Colors.white60,
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon =
                        new Icon(Icons.close, color: Colors.black);
                    this.appBarTitle = new TextField(
                      style: new TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.black),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.black)),
                    );
                  } else {
                    this.actionIcon =
                        new Icon(Icons.search, color: Colors.black);
                    this.appBarTitle = new Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 28,
                          color: Colors.grey,
                        ),
                        const Text(
                          "HOME",
                          style: TextStyle(color: Colors.black),
                        ),
                        const Text(
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
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 5  horizontally
              5.0, // Move to bottom 5 Vertically
            ),
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 100,
            width: double.infinity,
            color: Colors.blueGrey[200],
            child: const Center(
                child: Text(
              "REQUEST PAYMENT",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )),
          ),
        ),
      ),
      body: Container(
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount, // Two cards per row
              childAspectRatio:
                  childAspectRatio, // Aspect ratio of the cards (square)
            ),
            itemCount: filteredDetails.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonDetailPage()));
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
                            child:
                                Image.asset(filteredDetails[index]['profile']),
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 10),
                            child: Text(
                              '${filteredDetails[index]['name']}',
                              style: const TextStyle(
                                color: Color(0xFF1F2D36),
                                fontSize: 14,
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
                                filteredDetails[index]['years'],
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_searching,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  filteredDetails[index]['Near'],
                                  style: const TextStyle(color: Colors.grey),
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
            },
          ),
        ),
      ),
    );
  }
}

// class SearchAppBar extends StatefulWidget {
//   @override
//   _SearchAppBarState createState() => new _SearchAppBarState();
// }

// class _SearchAppBarState extends State<SearchAppBar> {
  // Widget appBarTitle = new Text("AppBar Title");
  // Icon actionIcon = new Icon(Icons.search);
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar:
      //     new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      //   new IconButton(
      //     icon: actionIcon,
      //     onPressed: () {
      //       setState(() {
      //         if (this.actionIcon.icon == Icons.search) {
      //           this.actionIcon = new Icon(Icons.close);
      //           this.appBarTitle = new TextField(
      //             style: new TextStyle(
      //               color: Colors.white,
      //             ),
      //             decoration: new InputDecoration(
      //                 prefixIcon: new Icon(Icons.search, color: Colors.white),
      //                 hintText: "Search...",
      //                 hintStyle: new TextStyle(color: Colors.white)),
      //           );
      //         } else {
      //           this.actionIcon = new Icon(Icons.search);
      //           this.appBarTitle = new Text("AppBar Title");
      //         }
      //       });
      //     },
      //   ),
      // ]),
//     );
//   }
// }
