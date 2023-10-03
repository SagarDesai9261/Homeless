import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homeless/Screen/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class Register_merchant extends StatefulWidget {
  @override
  State<Register_merchant> createState() => _Register_merchantState();
}

class _Register_merchantState extends State<Register_merchant> {
  List<String> imagePaths = [];
  List<XFile?> selectedImages = []; // Use XFile for image paths
  int currentIndex = 0;
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image and update the grid
  Future<void> pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImages.add(pickedImage);
        currentIndex++;
      });
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();
  TextEditingController choose_password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController appartment = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  bool checkvalue = false;
  bool password1 = true;
  bool password2 = true;
  final formkey = GlobalKey<FormState>();
  int currentStep = 0;
  List steps = [
    {
      'title': "Your Details",
    },
    {
      'title': "Business Details",
    },
    {
      'title': "Bank Details",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentStep > 0) {
          setState(() {
            currentStep--;
          });

          return false;
        } else {
          Navigator.of(context).pop();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Text('Register'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List<Widget>.generate(steps.length, (index) {
                    //  String name = widget.steps[index].title;
                    String text = steps[index]["title"];
                    List<String> words = text.split(" ");
                    return Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${words[0]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${words[1]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .25,
                          height: 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentStep >= index
                                  ? Colors.green
                                  : Colors.grey),
                        )
                      ],
                    );
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: currentStep == 0
                      ? Merchant_details(context)
                      : currentStep == 1
                          ? Merchant_Address_details(context)
                          : currentStep == 2
                              ? Merchant_Bank_details(context)
                              : Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Merchant_details(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: name,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Yash",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: email,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please Enter Email Address";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
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
                  controller: phone,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Choose Password',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Choose Password";
                    }
                    return null;
                  },
                  controller: choose_password,
                  obscureText: password1,
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      suffixIcon: IconButton(
                        icon: password1
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            password1 ? password1 = false : password1 = true;
                          });
                        },
                      ),
                      hintText: "Choose Password",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Confirm Password',
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
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Confirm Password";
                    } else if (value != choose_password.text) {
                      return "Both password is not Match";
                    }
                    return null;
                  },
                  obscureText: password2,
                  controller: confirm_password,
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: password2
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            password2 ? password2 = false : password2 = true;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
              )
            ],
          ),
          CheckboxListTile(
            title: Text(
              "I’ve read and agreed to Terms & conditions",
              style: TextStyle(fontSize: 14),
            ),
            value: checkvalue,
            onChanged: (newValue) {
              setState(() {
                if (checkvalue == true) {
                  checkvalue = false;
                } else {
                  checkvalue = true;
                }
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          InkWell(
            onTap: () {
              if (formkey.currentState!.validate()) {
                if (checkvalue == false) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please check the Terms and Condition")));
                } else {
                  print(name.text);
                  setState(() {
                    currentStep = currentStep + 1;
                  });
                }
              }

              //   print(DefaultTabController.of(context).index);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Merchant_Address_details(context)));
            },
            child: Container(
                width: 343,
                height: 50,
                decoration: ShapeDecoration(
                  color: Color(0xFF46BA80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Continue',
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
    );
  }

  Merchant_Address_details(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Business name',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: fullname,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Business name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Business name",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Business Category',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Business Category";
                    }
                    return null;
                  },
                  controller: address,
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Business Category",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Street Address',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Street Address";
                    }
                    return null;
                  },
                  controller: address,
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Street Address",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Area/Sector',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: appartment,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Area/Sector";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Area/Sector",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Pincode',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: city,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Pincode";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Pincode",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'State',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: state,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter State";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,

                      //suffixIcon: Icon(Icons.visibility),
                      hintText: "State",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Country',
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
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextFormField(
                  controller: country,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Country";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Country",
                      //suffixIcon: Icon(Icons.visibility),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload Registraction Certificate',
                  style: TextStyle(
                    color: Color(0xFF787878),
                    fontSize: 13,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: selectedImages.length +
                        1, // Add one for the "Add" button
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          3, // You can adjust the number of columns as needed
                      childAspectRatio:
                          1.0, // Set the aspect ratio to 1.0 for square items
                      mainAxisSpacing: 16.0, // Adjust the spacing as needed
                      crossAxisSpacing: 16.0, // Adjust the spacing as needed
                      // Set itemExtent to specify fixed height and width
                      // You can adjust these values as needed
                      // For example, if you want each item to be 100x100 pixels, set itemExtent: 100.0,
                      // itemExtent: 100.0,
                    ),
                    itemBuilder: (context, index) {
                      if (index < selectedImages.length) {
                        // Display selected image
                        String imagePath =
                            selectedImages[index]!.path; // Get the image path
                        imagePaths
                            .add(imagePath); // Add the image path to the list
                        return GestureDetector(
                          onLongPress: (){
                            setState(() {
                              selectedImages.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:FileImage(File(imagePath))
                              ),
                              border: Border.all(
                                color: Colors
                                    .grey, // Set the border color as desired
                                width: 1.0, // Set the border width as desired
                              ),
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius as desired
                            ),

                          ),
                        );
                      } else {
                        // Display "Add" button
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors
                                  .grey, // Set the border color as desired
                              width: 1.0, // Set the border width as desired
                            ),
                            borderRadius: BorderRadius.circular(
                                10.0), // Set border radius as desired
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed:
                                pickImage, // Call pickImage() when the button is pressed
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          InkWell(
            onTap: () {
              if (formkey.currentState!.validate()) {
                print(name.text);
                setState(() {
                  currentStep = currentStep + 1;
                });
              }
            },
            child: Container(
                width: 343,
                height: 50,
                decoration: ShapeDecoration(
                  color: Color(0xFF46BA80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Continue',
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
    );
  }

  Merchant_Bank_details(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Account Number',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: fullname,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Account Number";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Account Number",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Bank Name',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Bank Name";
                    }
                    return null;
                  },
                  controller: address,
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Bank Name",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'State',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter State";
                    }
                    return null;
                  },
                  controller: address,
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "State",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'City',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: city,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter City";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "City",
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
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Branch Location',
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
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextFormField(
                  controller: country,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Branch Location";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Branch Location",
                      //suffixIcon: Icon(Icons.visibility),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          InkWell(
            onTap: () {
              if (formkey.currentState!.validate()) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Navbar_screen()));
              }
            },
            child: Container(
                width: 343,
                height: 50,
                decoration: ShapeDecoration(
                  color: Color(0xFF46BA80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Continue',
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
    );
  }
}
