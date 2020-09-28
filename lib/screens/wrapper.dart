import 'package:flutter/material.dart';
import 'package:hospiqueue/models/user.dart';
import 'package:hospiqueue/screens/authenticate/authenticate.dart';
import 'package:hospiqueue/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:hospiqueue/models/doctor.dart';
import 'package:hospiqueue/models/hospital.dart';

class Wrapper extends StatelessWidget {
  static Doctor doctorForQueue = null;
  static Hospital hospitalForQueue = null;
  static bool showSignIn = null;
  static int queue = 0;
  static int curQueue = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}