import 'package:flutter/material.dart';

class demo2 extends StatefulWidget {
  String id;
   demo2({Key? key,required this.id}) : super(key: key);

  @override
  State<demo2> createState() => _demo2State();
}

class _demo2State extends State<demo2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child:Center(child: Text(widget.id))),
    );
  }
}
