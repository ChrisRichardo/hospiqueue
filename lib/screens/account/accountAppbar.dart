import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospiqueue/services/auth.dart';

class AccountAppbar extends StatelessWidget implements PreferredSizeWidget  {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('My Account', style: TextStyle(fontWeight: FontWeight.bold,),),
        backgroundColor: Color.fromRGBO(68, 215, 182, 1.0),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              await _auth.signOut();
            }, 
            child: Text('Logout', style: TextStyle(color: Colors.white),),
            ),
            Container(height: 1.0, child: VerticalDivider(color: Colors.white)),
            IconButton(
              onPressed: null, 
              icon: FaIcon(FontAwesomeIcons.solidEnvelope, color: Colors.white,), 
            ),
            IconButton(
              onPressed: null, 
              icon: FaIcon(FontAwesomeIcons.solidBell, color: Colors.white), 
              color: Colors.white,
            ),    
        ],
    );
  }
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

}