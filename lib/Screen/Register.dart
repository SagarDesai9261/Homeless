import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homeless/Screen/home_screen.dart';
import 'package:homeless/model/model.dart';
import 'package:homeless/model/service.dart';
import 'package:navbar_router/navbar_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StepModel {
  final String title;
  final Widget content;

  StepModel({required this.title, required this.content});
}

class Register_Organization extends StatefulWidget {
  @override
  _Register_OrganizationState createState() => _Register_OrganizationState();
}

class _Register_OrganizationState extends State<Register_Organization> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact_person = TextEditingController();
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
      'title': "Organization Details",
    },
    {
      'title': "Address Details",
    },
    {
      'title': "Upload Documents",
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
                Container(
                  child: currentStep == 0
                      ? Organization_details(context)
                      : currentStep == 1
                      ? Address_details(context)
                      : Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Organization_details(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Organization name',
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
                      hintText: "Organization name",
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
                  'Contact Person',
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
                      return "Please enter Contact person";
                    }
                    return null;
                  },
                  controller: contact_person,
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Contact Person",
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
                    }
                    else if(value.length < 10){
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
                    }
                    else if(value != choose_password.text){
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
                          });},
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
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_screen() ));
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

  Address_details(BuildContext context) {
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
                  controller: fullname,
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter Fullname";
                    }
                    return null;
                  },
                  decoration: InputDecoration(

                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Full name",
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
                  'Address',
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
                      return "Please enter Address";
                    }
                    return null;
                  },
                  controller: address,
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Address",
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
                  'Appartment name,society etc',
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
                      return "Please enter Appartment";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(0x1943BA82),
                      filled: true,
                      hintText: "Appartment name,society etc",
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
                      hintText: "city",
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
          InkWell(
            onTap: () {
              if(formkey.currentState!.validate()){
                UserApp user = UserApp(
                    organizationName : name.text,
                    email: email.text,
                    password: confirm_password.text,
                    contactPerson: contact_person.text,
                    phone: phone.text,
                    fullName: fullname.text,
                    address: address.text,
                    apartmentName: appartment.text,
                    city: city.text,
                    state: state.text,
                    country: country.text
                );
                AuthService().registerUser(user).then((value) => Alert(context: context,title:"Account Register Successfully",type: AlertType.success,buttons: [
                  DialogButton(
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () =>  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Navbar_screen())),
                    color: Color.fromRGBO(0, 179, 134, 1.0),
                    radius: BorderRadius.circular(0.0),
                  ),
                ],).show());

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


