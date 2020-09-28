import 'package:flutter/material.dart';
import 'package:hospiqueue/screens/authenticate/choose.dart';
import 'package:hospiqueue/screens/wrapper.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  void toggleView() {
    setState(() => Wrapper.showSignIn = !Wrapper.showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Choose();
  }
}