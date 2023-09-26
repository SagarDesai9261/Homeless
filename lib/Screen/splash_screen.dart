import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homeless/Screen/account_type.dart';

import '../model/service.dart';

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
class FigmaToCodeApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: ListView(
              ///physics: NeverScrollableScrollPhysics(),
              children: [
            Vector(),
          ]),
        );
  }
}

class Vector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width:  MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height > 600 ? MediaQuery.of(context).size.height * .5 :MediaQuery.of(context).size.height * .3 ,
        child: ClipRRect(
          child: Image.asset('assets/img.png'),
        ),
      ),
      Rectangle1()
    ]);
  }
}

class Rectangle1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width;
    var height;

    if(MediaQuery.of(context).orientation == Orientation.landscape) {
        width = MediaQuery.of(context).size.height;
        height = MediaQuery.of(context).size.width;
    }
    else{
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    }
    print(height);



    return Container(
      width: 2000,
      height: height * .45,
      decoration: ShapeDecoration(
        color: Color(0xFF1F2D36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(100),topRight: Radius.circular(100)),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Let us help the community',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w600,
                height: 4,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Text(
                'Lorem ipsum dolor sit amet consectetur. Dui risus vel risus sed nulla.Lorem ipsum dolor sit amet consectetur. Dui risus vel risus sed nulla.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6000000238418579),
                  fontSize: 16,
                  fontFamily: 'SF Pro Text',
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: height * .02,),
            if(height > 700)
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: ()async{
                    try {
                      AuthService().signInWithGoogle();
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: Container(
                    width: 343,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: Color(0xFF434C54),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/google.png',
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w500,
                              height: 0.06,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                  //  print(width);
                   //print(height);
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> Account_type() ));
                  },
                  child: Container(
                      width: 343,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Color(0xFF46BA80),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Sign to your Account',
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


          ],
        ),
      ),
    );
  }
}
