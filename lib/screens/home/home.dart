import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospiqueue/screens/account/account.dart';
import 'package:hospiqueue/screens/account/accountAppbar.dart';
import 'package:hospiqueue/screens/home/homeAppbar.dart';
import 'package:hospiqueue/screens/home/homeBody.dart';
import 'package:hospiqueue/screens/queue/queue.dart';
import 'package:hospiqueue/screens/queue/queueAppbar.dart';
import 'package:hospiqueue/services/auth.dart';

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    Queue(),
    HomeBody(),
    Account()
  ];
  final List<Widget> _appBarChildren = [
    QueueAppbar(),
    HomeAppbar(),
    AccountAppbar()
  ];
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(68, 215, 182, 1.0),
      appBar: _appBarChildren[_currentIndex],
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        selectedItemColor: Color.fromRGBO(68, 215, 182, 1.0),
       currentIndex: _currentIndex,
       items: [
         BottomNavigationBarItem(
           icon: FaIcon(FontAwesomeIcons.users),
           title: new Text('Queue'),
         ),
         BottomNavigationBarItem(
           icon: FaIcon(FontAwesomeIcons.home),
           title: new Text('Home'),
         ),
         BottomNavigationBarItem(
           icon: FaIcon(FontAwesomeIcons.solidUser),
           title: Text('Account')
         )
       ],
     ),
        
    );
  }

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

}