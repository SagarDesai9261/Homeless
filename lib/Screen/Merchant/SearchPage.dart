import 'package:flutter/material.dart';

class SearchPageMerchant extends StatefulWidget {
  @override
  State<SearchPageMerchant> createState() => _SearchPageMerchantState();
}

class _SearchPageMerchantState extends State<SearchPageMerchant> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  color: Colors.white10,
                  child: Row(
                    children: [
                      IconButton(
                          iconSize: 24,
                          color: Colors.grey,
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back)),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 24,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              'Enter your name', // Add your label text here
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 11,
                child: Container(
                  height: 50,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
