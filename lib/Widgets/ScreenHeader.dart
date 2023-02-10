import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AppFormField.dart';

class ScreenHeader extends StatefulWidget {
  const ScreenHeader({super.key});

  @override
  State<ScreenHeader> createState() => _ScreenHeaderState();
}

class _ScreenHeaderState extends State<ScreenHeader> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.20,
        color: Colors.lightGreenAccent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Good Morning'),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 200,
                      right: 20,
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/cat.jpeg'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Tester'),
                ],
              ),
            ),
            AppFormField(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
