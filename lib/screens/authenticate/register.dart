import 'package:flutter/material.dart';
import 'package:hospiqueue/services/auth.dart';
import 'package:hospiqueue/shared/constants.dart';
import 'package:hospiqueue/shared/loading.dart';

import '../wrapper.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  String email = "";
  String password = "";
  String name = "";
  String error = "";

  Widget _title() {
    return Image(image: AssetImage("assets/LogoBig.png"));
  }

  @override
  Widget build(BuildContext context) {
    Wrapper.showSignIn = true;
    Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      body: SingleChildScrollView(
              child: Column(
            children: <Widget> [Padding(child: _backButton(), padding: EdgeInsets.only(top: 30),),Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _title(),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                    validator: (val) => val.isEmpty ? 'Enter your name' : null,
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  ),
                  SizedBox(height: 20.0,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                      child: RaisedButton(
                      color: Color.fromRGBO(68, 215, 182, 1.0),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password, name);
                          if(result == null){
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          }
                          else{
                            setState((){
                              loading = false;
                              Navigator.pop(context);
                            });
                          }
                        }
                      }
                    ),
                  ),
                  SizedBox(height: 12.0,),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
                ),
              ),
          ),
                ]),
      )
    );
  }
}