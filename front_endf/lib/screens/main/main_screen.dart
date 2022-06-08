import 'package:flutter/material.dart';

import '../../responsive.dart';
import '../../splash screens/onboard.dart';
import '../../widgets/language_picker_widget.dart';



class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    return Scaffold(


      body: Responsive(
        // Let's work on our mobile part
        mobile: OnboardingScreen(),
        //OnboardScreen(),
        tablet: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.greenAccent,
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                color: Colors.amberAccent,

              ),
            ),
          ],
        ),
        web: Row(
          children: [
            // Once our width is less then 1300 then it start showing errors
            // Now there is no error if our width is less then 1340
            Expanded(
              flex: _size.width > 1340 ? 2 : 4,
              child: Container(
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: _size.width > 1340 ? 3 : 5,
              child: Container(
                color: Colors.greenAccent,
              ),
            ),
            Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: Container(
                color: Colors.amberAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
