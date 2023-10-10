import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class MapScreen extends StatefulWidget {
  int user_index;
  MapScreen({
    required this.user_index,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isLoading = true;
  int calculateAge(DateTime dob) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;

    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    return age;
  }

  String formatJoinDate(String joinDate) {
    if (joinDate != null && joinDate.isNotEmpty) {
      final parsedDate = DateTime.parse(joinDate);
      return DateFormat('dd MMM, yyyy').format(parsedDate);
    } else {
      return 'No join date available';
    }
  }

  GoogleMapController? mapController;
  final LatLng _center = const LatLng(21.5397, 71.5776);
  PageController pageController = PageController(initialPage: 0);
  List<LocationInfo> locationsFromFirestore = [];

  int selectedLocationIndex = 0;

  String? fullNameController = '';
  LatLng? selectedLocation;
  String? profileI;

  @override
  void initState() {
    super.initState();

    // Define a new list to store LocationInfo objects

// Fetch member data from Firestore based on the memberId
    fetchDataFromFirestore();
  }

//   void fetchDataFromFirestore() async {
//     try {
//       FirebaseFirestore.instance
//           .collection('HomeLessMembers')
//           .doc('Nmiv1MwkbGAEgJbNxHnU')
//           .get()
//           .then((DocumentSnapshot documentSnapshot) {
//         if (documentSnapshot.exists) {
//           // Retrieve data from Firestore
//           Map<String, dynamic> data =
//               documentSnapshot.data() as Map<String, dynamic>;

//           // Create a LocationInfo object from Firestore data
//           LocationInfo locationInfo = LocationInfo(
//             profile_image: data['profileImageUrl'] ?? '',
//             position: LatLng(
//               double.parse(data['latitude'].toString()),
//               double.parse(data['longitude'].toString()),
//             ),
//             userName: data['userName'] ?? '',
//             address: data['address'] ?? '',
//             year: calculateAge(DateTime.parse(data['dob'])),
//             deviceAllocated: data['allotDevice'] ?? '',
//             deviceSerial: data['deviceSerial'] ?? '',
//             donationReceived: data['donationRecived'] ?? '',
//             walletBalance: data['walletBalance'] ?? 0.0,
//             memberSince: formatJoinDate(data['joinDate']) ?? '',
//           );

//           // Add the LocationInfo object to the new list
//           locationsFromFirestore.add(locationInfo);

//           // Update the state and controllers with retrieved data
//           setState(() async {
//             isLoading = false;
//           });
//         } else {
//           // Handle the case where the document does not exist
//           print('Document does not exist');
//         }
//       }).catchError((error) {
//         // Handle errors
//         print('Error fetching data: $error');
//         setState(() {
//           isLoading = false; // Set isLoading to false in case of an error
//         });
//       });

// // Update the original locations list with the data from Firestore
//       setState(() {
//         locationsFromFirestore = locationsFromFirestore;
//       });
//     } catch (e) {
//       print('Error fetching data: $e');
//       setState(() {
//         isLoading = false; // Set isLoading to false in case of an error
//       });
//     }
//   }

  void fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('HomeLessMembers').get();

      if (querySnapshot.docs.isNotEmpty) {
        // Clear the existing list before adding new data
        locationsFromFirestore.clear();

        // Loop through the documents to retrieve data for each member
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          // Retrieve data from Firestore for each member
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;

          // Create a LocationInfo object from Firestore data
          LocationInfo locationInfo = LocationInfo(
            profile_image: data['profileImageUrl'] ?? '',
            position: LatLng(
              double.parse(data['latitude'].toString()),
              double.parse(data['longitude'].toString()),
            ),
            userName: data['fullName'] ?? '',
            address: data['address'] ?? '',
            year: calculateAge(DateTime.parse(data['dob'])),
            deviceAllocated: data['allotDevice'] ?? '',
            deviceSerial: data['deviceSerial'] ?? '',
            donationReceived: data['donationRecived'] ?? '',
            walletBalance: data['walletBalance'] ?? 0.0,
            memberSince: formatJoinDate(data['joinDate']) ?? '',
          );

          // Add the LocationInfo object to the list
          locationsFromFirestore.add(locationInfo);
        }

        // Update the state and controllers with retrieved data
        setState(() async {
          isLoading = false;
        });
      } else {
        // Handle the case where no documents exist in the collection
        print('No documents found in the collection');
      }
    } catch (error) {
      // Handle errors
      print('Error fetching data: $error');
      setState(() {
        isLoading = false; // Set isLoading to false in case of an error
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    //_onPageChanged(widget.user_index);
    mapController!.animateCamera(CameraUpdate.newLatLng(
        locationsFromFirestore[selectedLocationIndex].position));
    pageController.jumpToPage(widget.user_index);
  }

  Set<Marker> _generateMarkers() {
    Set<Marker> markers = {};
    for (int i = 0; i < locationsFromFirestore.length; i++) {
      markers.add(
        Marker(
          onTap: () {
            _onMarkerTapped(i);
          },
          markerId: MarkerId('marker_$i'),
          position: locationsFromFirestore[i].position,
          infoWindow: InfoWindow(
            title: locationsFromFirestore[i].userName,
            snippet: locationsFromFirestore[i].address,
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }
    return markers;
  }

  void _onMarkerTapped(int index) {
    setState(() {
      selectedLocationIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.ease,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      selectedLocationIndex = index;
      mapController!.animateCamera(CameraUpdate.newLatLng(
          locationsFromFirestore[selectedLocationIndex].position));
    });

    // if (index == locationsFromFirestore.length - 1) {
    //   // If the last page is reached, wrap around to the first page.
    //   pageController.jumpToPage(0);
    // }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          // title: Text('Location Slider'),
        ),
        body: Center(
          child: CircularProgressIndicator(), // Circular progress indicator
        ),
      );
    }
    LocationInfo currentLocation =
        locationsFromFirestore[selectedLocationIndex];

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        // title: Text('Location Slider'),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GoogleMap(
            markers: _generateMarkers(),
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(zoom: 11.0, target: _center),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              height: height > 660
                  ? MediaQuery.of(context).size.height * .45
                  : MediaQuery.of(context).size.height *
                      .57, // Adjust the height as needed
              child: PageView.builder(
                controller: pageController,
                itemCount: locationsFromFirestore.length,
                onPageChanged: (int index) {
                  _onPageChanged(index);
                },
                itemBuilder: (BuildContext context, int index) {
                  print(selectedLocationIndex);
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Container(
                            width: 62,
                            height: 62,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(currentLocation
                                    .profile_image), // Replace with actual image path
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          title: Text(
                            currentLocation.userName,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            currentLocation.address,
                            style: const TextStyle(fontSize: 10),
                          ),
                          trailing: Container(
                            width: 67,
                            height: 24,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0x1443BA82),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              '${locationsFromFirestore[index].year.toString()} Years',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Color(0xFF43BA82),
                                fontSize: 12,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            'Device allotted ',
                            style: TextStyle(
                              color: Color(0xFF787878),
                              fontSize: 14,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                          trailing: Text(
                            currentLocation.deviceAllocated,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF1F2D36),
                              fontSize: 14,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w500,
                              height: .04,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width * .80,
                            child: const Divider(
                              height: 1,
                              thickness: 2,
                            )),
                        ListTile(
                          title: const Text(
                            'Device serial ',
                            style: TextStyle(
                              color: Color(0xFF787878),
                              fontSize: 14,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                          trailing: Text(
                            currentLocation.deviceSerial,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF1F2D36),
                              fontSize: 14,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width * .80,
                            child: const Divider(
                              height: 1,
                              thickness: 2,
                            )),
                        ListTile(
                          title: const Text(
                            'Donation received ',
                            style: TextStyle(
                              color: Color(0xFF787878),
                              fontSize: 14,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                          trailing: Text(
                            '\$${currentLocation.donationReceived}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF1F2D36),
                              fontSize: 14,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width * .80,
                            child: const Divider(
                              height: 1,
                              thickness: 2,
                            )),
                        ListTile(
                          title: const Text(
                            'Wallet balance ',
                            style: TextStyle(
                              color: Color(0xFF787878),
                              fontSize: 14,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                          trailing: Text(
                            '\$${currentLocation.walletBalance}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF1F2D36),
                              fontSize: 14,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width * .80,
                            child: const Divider(
                              height: 1,
                              thickness: 2,
                            )),
                        ListTile(
                          title: const Text(
                            'Member since ',
                            style: TextStyle(
                              color: Color(0xFF787878),
                              fontSize: 14,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                          trailing: Text(
                            currentLocation.memberSince,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF1F2D36),
                              fontSize: 14,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationInfo {
  final LatLng position;
  final String userName;
  final String address;
  final int year;
  final String deviceAllocated;
  final String deviceSerial;
  final String donationReceived;
  final String walletBalance;
  final String memberSince;
  // ignore: non_constant_identifier_names
  final String profile_image;

  LocationInfo(
      {required this.position,
      required this.userName,
      required this.address,
      required this.year,
      required this.deviceAllocated,
      required this.deviceSerial,
      required this.donationReceived,
      required this.walletBalance,
      required this.memberSince,
      required this.profile_image});
}
