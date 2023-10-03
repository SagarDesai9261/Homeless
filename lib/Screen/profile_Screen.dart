import 'package:flutter/material.dart';

class DonorSProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .9,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1F2D36),
                      fontSize: 18,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image:
                                AssetImage("assets/user_profile.png"),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFF43BA82),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        margin: const EdgeInsets.only(left: 40, top: 90),
                        decoration: const ShapeDecoration(
                          //color: Color(0xFF43BA82),
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                          ),
                        ),
                        child: Image.asset("assets/edit_image.png"),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      const Text(
                        'Omar Lipshutz',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1F2D36),
                          fontSize: 16,
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.mode_edit_outline_outlined,
                            size: 16,
                            color: Color(0xFF43BA82),
                          )),
                    ],
                  ),
                  const Text(
                    '@omarlip123',
                    style: TextStyle(
                      color: Color(0xFF787878),
                      fontSize: 14,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w400,
                      height: 0.5,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .85,
                    height: MediaQuery.of(context).size.height > 660 ? MediaQuery.of(context).size.height*.5 :  MediaQuery.of(context).size.height*.6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(
                              1.0,
                              1.0,
                            ),
                            blurRadius: 3.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                        ]),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFEDF9F3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Icon(Icons.phone,color: Color(0xFF43BA82),),
                          ),
                          title: const Text('+1 6564564556'),
                          trailing:Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Image.asset("assets/arrow.png"),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: const Divider(height: 2,thickness: 2,)),
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFEDF9F3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Icon(Icons.mail,color: Color(0xFF43BA82),),
                          ),
                          title: const Text('omar.lipshutz@mail.com'),
                          trailing:Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                              child: Image.asset("assets/arrow.png")
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: const Divider(height: 2,thickness: 2,)),
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFEDF9F3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Image.asset("assets/year.png"),
                          ),
                          title: const Text('34 Years'),
                          trailing:Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                              child: Image.asset("assets/arrow.png")
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: const Divider(height: 2,thickness: 2,)),
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFEDF9F3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Image.asset("assets/location.png"),
                          ),
                          title: const Text('Miami,USA'),
                          trailing:Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                              child: Image.asset("assets/arrow.png")

                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: const Divider(height: 2,thickness: 2,)),
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFEDF9F3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Image.asset("assets/gender.png"),
                          ),
                          title: const Text('Male'),
                          trailing:Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                              child: Image.asset("assets/arrow.png")
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: const Divider(height: 2,thickness: 2,)),
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFEDF9F3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Icon(Icons.info_outline,color: Color(0xFF43BA82),),
                          ),
                          title:const Text("Lorem ipsum dolor sit amet consectetur. Varius quis habitasse diam morbi purus purus vulputate cras id.",style: TextStyle(
                            color: Color(0xFF1F2D36),
                            fontSize: 14,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                          ),) ,
                          trailing:Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                              child: Image.asset("assets/arrow.png")
                          ),

                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
