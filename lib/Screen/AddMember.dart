import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homeless/Screen/CustomSnackBar.dart';
import 'package:homeless/Screen/EditMemberPage.dart';
import 'package:homeless/model/model.dart';

class AddMemberPage extends StatefulWidget {
  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  bool isLoading = false;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController deviceSerialController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedGender = '';
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  String? allotDevice = 'Yes';
  String? genderValidationError;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[200]),
        title: const Text(
          'Add Member',
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
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.amber[50],
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/user_2.png'),
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      controller: pinController,
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
                      controller: userNameController,
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
                                ? Colors.green // Change color when selected
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
                                ? Colors.green // Change color when selected
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
                    SizedBox(width: 16), // Add spacing between dropdowns
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
                    SizedBox(width: 16), // Add spacing between dropdowns
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
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      width: 16), // Add spacing between Text and Radio buttons
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
                            color: Colors.grey, fontWeight: FontWeight.bold),
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
                            color: Colors.grey, fontWeight: FontWeight.bold),
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
                  if (formKey.currentState!.validate()) {
                    setState(() async {
                      setState(() {
                        isLoading = true;
                      });
                      Member member = Member(
                        fullName: fullNameController
                            .text, // Full Name from TextEditingController
                        email: emailController
                            .text, // Email from TextEditingController
                        phone: phoneController
                            .text, // Phone from TextEditingController
                        gender: selectedGender,
                        dayOfBirth: selectedDay,
                        monthOfBirth: selectedMonth,
                        yearOfBirth: selectedYear,
                        allotDevice: allotDevice,
                        deviceSerial: deviceSerialController.text,
                        pinNumber: pinController.text,
                        userName: userNameController
                            .text, // Device Serial from TextEditingController
                      );

                      final CollectionReference membersCollection =
                          FirebaseFirestore.instance
                              .collection('HomeLessMembers');

                      await membersCollection.add({
                        'fullName': member.fullName,
                        'email': member.email,
                        'phone': member.phone,
                        'gender': member.gender,
                        'dayOfBirth': member.dayOfBirth,
                        'monthOfBirth': member.monthOfBirth,
                        'yearOfBirth': member.yearOfBirth,
                        'allotDevice': member.allotDevice,
                        'deviceSerial': member.deviceSerial,
                        'pinNumber': member.pinNumber,
                        'userName': member.userName,
                      });

                      setState(() {
                        isLoading = false;
                      });
                      final snackBar = SnackBar(
                        content: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ), // Add padding to all sides
                          child: Text('This is a SnackBar with padding'),
                        ),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the borderRadius
                        ),
                        padding: EdgeInsets.all(16.0), // Set padding
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // Now you can use the 'member' object or send it to Firebase or perform any other actions with it
                      // For example, you can add it to Firebase Firestore as shown in the previous answer.
                    });
                  }
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
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditMemberPage(
                        memberId: 'sbIp2VCTa0vJPyzcdSYf',
                        initialFullName: '',
                        initialEmail: '',
                        initialPhone: '',
                        initialGender: '',
                        initialAllotDevice: '',
                        initialDay: '',
                        initialDeviceSerial: '',
                        initialMonth: '',
                        initialYear: '',
                        initialPinNumber: '',
                        initialUserName: '',
                      )));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final String label;
  final List<String> options;
  final String? selectedValue;
  final void Function(String?) onChanged;

  CustomDropdown({
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _showDropdownMenu,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Color(0x1943BA82),
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.selectedValue ?? '${widget.label}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDropdownMenu() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            itemCount: widget.options.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(widget.options[index]),
                onTap: () {
                  widget.onChanged(widget.options[index]);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }
}
