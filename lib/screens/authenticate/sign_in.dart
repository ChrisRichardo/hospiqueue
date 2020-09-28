import 'package:flutter/material.dart';
import 'package:hospiqueue/screens/authenticate/authenticate.dart';
import 'package:hospiqueue/screens/wrapper.dart';
import 'package:hospiqueue/services/auth.dart';
import 'package:hospiqueue/shared/constants.dart';
import 'package:hospiqueue/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  String email = "";
  String password = "";
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

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      body: SingleChildScrollView(
              child: Column(
                children: <Widget>[Padding(child: _backButton(), padding: EdgeInsets.only(top: 30),),Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _title(),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  ),
                  SizedBox(height: 20.0,),
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
                        "Sign in",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if(result == null){
                            setState(() {
                              error = "Could not sign in with those credentials";
                              loading = false;
                            });
                          }
                          else{
                            setState((){
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
                  ),
                ],
                ),
              ),
          ),
                ]),
      )
    );
  }
}