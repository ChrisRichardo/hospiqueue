import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget  {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0.0,
      title: Container(width: MediaQuery.of(context).size.width * 0.5, child: Image.asset("assets/LogoForApp.png", fit: BoxFit.cover,)),
         backgroundColor: Color.fromRGBO(68, 215, 182, 1.0),
      actions: <Widget>[
          FlatButton.icon(
            onPressed: null,
              label: Text('Rp. 200.000', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              icon: FaIcon(FontAwesomeIcons.wallet, color: Colors.white,),
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