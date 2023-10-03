import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homeless/Screen/Add_job_post_Screen.dart';
import 'package:homeless/Screen/account_type.dart';
import 'package:homeless/Screen/profile_Screen.dart';
import 'package:homeless/Screen/wallet_screen.dart';
import '../model/service.dart';
import 'map.dart';
class Navbar_screen extends StatefulWidget {
  const Navbar_screen({Key? key}) : super(key: key);

  @override
  State<Navbar_screen> createState() => _Navbar_screenState();
}

class _Navbar_screenState extends State<Navbar_screen> {
  late List<Widget> navbar_list = [
    homeview(),
    walletview(),
    notificationview(),
    profileview()
  ];
  int select_index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  select_index = 0;
                });
              },
              child: Column(
                children: [
                  if (select_index == 0) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF43BA82),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 3,
                          color: Colors.green,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      "Home",
                      style: TextStyle(color: Color(0xFF43BA82)),
                    )
                  ],
                  if (select_index != 0) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 60,
                      child: const Center(
                        child: Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Text(
                      "Home",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  select_index = 1;
                });
              },
              child: Column(
                children: [
                  if (select_index == 1) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF43BA82),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 3,
                          color: Colors.green,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      "Wallet",
                      style: TextStyle(color: Color(0xFF43BA82)),
                    )
                  ],
                  if (select_index != 1) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 60,
                      child: const Center(
                        child: Icon(
                          Icons.wallet,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Text(
                      "wallet",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  select_index = 2;
                });
              },
              child: Column(
                children: [
                  if (select_index == 2) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF43BA82),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 3,
                          color: Colors.green,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child:  Icon(
                          Icons.notification_important_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      "Notification",
                      style: TextStyle(color: Color(0xFF43BA82)),
                    )
                  ],
                  if (select_index != 2) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 60,
                      child: const Center(
                        child: Icon(
                          Icons.notification_important_sharp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Text(
                      "Notification",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  select_index = 3;
                });
              },
              child: Column(
                children: [
                  if (select_index == 3) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF43BA82),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 3,
                          color: Colors.green,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    const Text(
                      "Profile",
                      style: TextStyle(color: Color(0xFF43BA82)),
                    )
                  ],
                  if (select_index != 3) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 60,
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Text(
                      "Profile",
                      style: TextStyle(color: Colors.grey,),
                    )
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: navbar_list[select_index],
    );
  }

  homeview() {
    return const Home_screen();
  }

  walletview() {
    return const Wallet_page();
  }

  notificationview() {
    return const add_job_post_screen();
  }

  profileview() {
    return DonorSProfile();
  }
}

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredDetails = details;
  }
  List filteredDetails = [];
  List details = [
    {
      'index':0,
      'profile': "assets/user_1.png",
      'name': "John Doe",
      'location': "New York",
      'years': "28 Years"
    },
    {
      'index':1,
      'profile': "assets/user_2.png",
      'name': "Alice Johnson",
      'location': " California",
      'years': "32 Years"
    },
    {
       'index':2,
      'profile': "assets/user_3.png",
      'name': "Madelyn Ekstrom",
      'location': "Chicago",
      'years': "30 Years"
    },
    {
      'index':3,
      'profile': "assets/user_4.png",
      'name': "Martin Levin",
      'location': "Miami",
      'years': "32 Years"
    },
    {
      'index':4,
      'profile': "assets/user_5.png",
      'name': "Marley Geldt",
      'location': "Colorado",
      'years': "32 Years"
    },
    {
      'index':5,
      'profile': "assets/user_6.png",
      'name': "Mira Lubin",
      'location': "Washington",
      'years': "32 Years"
    },
  ];
  void _filterbyName(String query){
    setState(() {
      if (query.isEmpty) {
        // If the query is empty, show all items.
        filteredDetails = details;
      } else {
        // Use the 'where' method to filter items by name.
        filteredDetails = details.where((item) {
          final name = item['name'].toLowerCase();
          final searchQuery = query.toLowerCase();
          return name.contains(searchQuery);
        }).toList();
      }
    });
  }
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop : ()async{
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on), // Add your location icon here
              SizedBox(width: 5), // Add spacing between icon and text
              Text('New York City'),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .8,
                      // padding: EdgeInsets.all(8),
                      child: TextFormField(
                        controller: search,
                        onChanged: _filterbyName,

                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none
                            ),
                            label: Text("Search"),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: const Icon(Icons.search),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Image.asset(
                      "assets/filter.png",
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: const Color(0xFF43BA82),
          actions: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/user.png"),
              ),
            )
          ],
        ),
        drawer:  SizedBox(
          width: 200,
          child: Drawer(
            child:
            SafeArea(
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sign Out'),
                onTap: () {
                  // Sign out the user when the "Sign Out" button is pressed
                  AuthService().signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Account_type()));
                  //Navigator.pop(context); // Close the drawer
                },
              ),
            ),
          ),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two cards per row
            childAspectRatio: 1.0, // Aspect ratio of the cards (square)
          ),
          itemCount: filteredDetails.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //elevation: 2.0, // Card elevation
              //margin: EdgeInsets.all(10.0), // Margin around each card
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ClipRRect(
                          //borderRadius: BorderRadius.zero,
                          child: Image.asset(filteredDetails[index]['profile']),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${filteredDetails[index]['name']}',
                        style: const TextStyle(
                          color: Color(0xFF1F2D36),
                          fontSize: 16,
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w600,
                          height: 0.07,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(user_index: filteredDetails[index]['index'],)));
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_on),
                                Text(filteredDetails[index]['location']),
                              ],
                            ),
                            Text("(Click Here)",style: TextStyle(
                              fontSize: 12
                            ),)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(230, 255, 230, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          filteredDetails[index]['years'],
                          style: const TextStyle(color: Color(0xFF43BA82)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


}
