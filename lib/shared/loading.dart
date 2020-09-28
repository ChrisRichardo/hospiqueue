import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(68, 215, 182, 1.0),
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.teal,
          size: 50.0,
        ),
      ),
    );
  }
}