import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homeless/Screen/Organization/AddMember.dart';
import 'package:homeless/model/model.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class EditMemberPage extends StatefulWidget {
  final String
      memberId; // You may need to pass the member ID to identify the member you want to edit.
  final String initialFullName;
  final String initialEmail;
  final String initialPhone;
  final String initialGender;
  final String initialDay;
  final String initialMonth;
  final String initialYear;
  final String initialAllotDevice;
  final String initialDeviceSerial;
  final String initialPinNumber;
  final String initialUserName;

  EditMemberPage(
      {required this.memberId,
      required this.initialFullName,
      required this.initialEmail,
      required this.initialPhone,
      required this.initialGender,
      required this.initialDay,
      required this.initialMonth,
      required this.initialYear,
      required this.initialDeviceSerial,
      required this.initialAllotDevice,
      required this.initialPinNumber,
      required this.initialUserName});

  @override
  _EditMemberPageState createState() => _EditMemberPageState();
}

class _EditMemberPageState extends State<EditMemberPage> {
  bool isLoading = true;

  String? genderValidationError;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController deviceSerialController = TextEditingController();
  TextEditingController pinNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  // Add controllers for other fields

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedGender = '';
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  String? allotDevice = 'Yes';
  String? profileI = '';

  List<String> days = List.generate(31, (index) => (index + 1).toString());
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> years =
      List.generate(100, (index) => (DateTime.now().year - index).toString());

  @override
  void initState() {
    super.initState();

    // Fetch member data from Firestore based on the memberId
    FirebaseFirestore.instance
        .collection('HomeLessMembers')
        .doc(widget.memberId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Retrieve data from Firestore
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        print('${widget.memberId}');

        // Update the state and controllers with retrieved data
        setState(() async {
          isLoading = false;
          fullNameController.text = data['fullName'] ?? '';
          emailController.text = data['email'] ?? '';
          phoneController.text = data['phone'] ?? '';
          deviceSerialController.text = data['deviceSerial'] ?? '';
          selectedGender = data['gender'] ?? '';
          selectedDay = data['dayOfBirth'] ?? '';
          selectedMonth = data['monthOfBirth'] ?? '';
          selectedYear = data['yearOfBirth'] ?? '';
          allotDevice = data['allotDevice'] ?? 'Yes';
          pinNumberController.text = data['pinNumber'] ?? '';
          userNameController.text = data['userName'] ?? '';
          profileI = data['profileImage'] ?? '';
          print('Profile :${profileI}');
        });
      } else {
        // Handle the case where the document does not exist
        print('Document does not exist');
      }
    }).catchError((error) {
      // Handle errors
      print('Error fetching data: $error');
      setState(() {
        isLoading = false; // Set isLoading to false in case of an error
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[200]),
        title: const Text(
          'Edit Member',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              if (isLoading)
                Container(
                  height: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Container(child: CircularProgressIndicator())),
                    ],
                  ),
                ) // Show progress indicator when isLoading is true
              else
                Container(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.amber[50],
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage("${profileI.toString()}"),
                          radius: 50,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: const Text(
                              'Full name',
                              style: TextStyle(
                                color: Color(0xFF787878),
                                fontSize: 13,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: fullNameController,
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please enter name";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  fillColor: const Color(0x1943BA82),
                                  filled: true,
                                  hintText: "Full Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none)),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: const Text(
                              'Email Address',
                              style: TextStyle(
                                color: Color(0xFF787878),
                                fontSize: 13,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please Enter Email Address";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  fillColor: const Color(0x1943BA82),
                                  filled: true,
                                  hintText: "Email Address",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none)),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: const Text(
                              'Phone',
                              style: TextStyle(
                                color: Color(0xFF787878),
                                fontSize: 13,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: phoneController,
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please enter Phone";
                                } else if (value.length < 10) {
                                  return "Please enter valid Phone";
                                }
                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              // controller: phone,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  fillColor: const Color(0x1943BA82),
                                  filled: true,
                                  hintText: "Phone",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none)),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: const Text(
                              'Username',
                              style: TextStyle(
                                color: Color(0xFF787878),
                                fontSize: 13,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child: TextFormField(
                              controller: userNameController,
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please enter Username";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  fillColor: const Color(0x1943BA82),
                                  filled: true,
                                  hintText: "Username",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: const Text(
                              'Choose The 6-digit PIN',
                              style: TextStyle(
                                color: Color(0xFF787878),
                                fontSize: 13,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: pinNumberController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                              ],
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please enter The 6-digit PIN";
                                } else if (value.length < 6) {
                                  return "Please enter valid PIN";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  fillColor: const Color(0x1943BA82),
                                  filled: true,
                                  hintText: "Choose The 6-digit PIN",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none)),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedGender = "Male";
                                genderValidationError =
                                    null; // Clear validation message
                              });
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/man.png',
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                    color: selectedGender == "Male"
                                        ? Colors
                                            .green // Change color when selected
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20), // Add spacing between images
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedGender = "Female";
                                genderValidationError =
                                    null; // Clear validation message
                              });
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/woman.png',
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                    color: selectedGender == "Female"
                                        ? Colors
                                            .green // Change color when selected
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (genderValidationError != null)
                        Text(
                          genderValidationError!,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 18),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Date OF Birth',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF787878),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomDropdown(
                                label: 'Day',
                                options: days,
                                selectedValue: selectedDay,
                                onChanged: (value) {
                                  setState(() {
                                    selectedDay = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                                width: 16), // Add spacing between dropdowns
                            Expanded(
                              flex: 1,
                              child: CustomDropdown(
                                label: 'Month',
                                options: months,
                                selectedValue: selectedMonth,
                                onChanged: (value) {
                                  setState(() {
                                    selectedMonth = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                                width: 16), // Add spacing between dropdowns
                            Expanded(
                              flex: 1,
                              child: CustomDropdown(
                                label: 'Year',
                                options: years,
                                selectedValue: selectedYear,
                                onChanged: (value) {
                                  setState(() {
                                    selectedYear = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Allot Device?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                              width:
                                  16), // Add spacing between Text and Radio buttons
                          Row(
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: allotDevice,
                                onChanged: (value) {
                                  setState(() {
                                    allotDevice = value as String?;
                                  });
                                },
                              ),
                              Text(
                                'Yes',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'No',
                                groupValue: allotDevice,
                                onChanged: (value) {
                                  setState(() {
                                    allotDevice = value as String?;
                                  });
                                },
                              ),
                              Text(
                                'No',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: const Text(
                              'Device Serial',
                              style: TextStyle(
                                color: Color(0xFF787878),
                                fontSize: 13,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: deviceSerialController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                              ],
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please enter Device Serial";
                                } else if (value.length < 6) {
                                  return "Please enter valid PIN";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  fillColor: const Color(0x1943BA82),
                                  filled: true,
                                  hintText: "Device Serial",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none)),
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {}
                          ;
                        },
                        child: Container(
                            width: 343,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF46BA80),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: isLoading
                                ? Center(
                                    child:
                                        CircularProgressIndicator()) // Show progress indicator when isLoading is true
                                : const Text('Continue',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'SF Pro Text',
                                      fontWeight: FontWeight.w600,
                                      height: 2,
                                    ))),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
