import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospiqueue/shared/loading.dart';

var userName;

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var isLoading = true;
  final List _iconAccount = [FontAwesomeIcons.pencilAlt, FontAwesomeIcons.tag, FontAwesomeIcons.userFriends, FontAwesomeIcons.notesMedical];

  final List _titleAccount = ['Edit Account Information', 'Enter Promo Code', "Invite Friends", "My Activities"];

  final List _iconGeneral = [FontAwesomeIcons.shieldAlt, FontAwesomeIcons.clipboard, FontAwesomeIcons.solidStar];

  final List _titleGeneral = ['Privacy Policy', 'Terms of Service', "Give Us Feedback"];


  inputData() async {
    setState(() {
      isLoading = true;
    });
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    userName = user.displayName;
    setState(() {
      isLoading = false;
    });
    // here you write the codes to input the data into firestore
  }

  void initState() {
    super.initState();
    inputData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : Container(
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              //User Information
              Container(
                width: MediaQuery.of(context).size.width*0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       new Container(
                          width: 100,
                          height: 100,
                          decoration: new BoxDecoration(
                            border: Border.all(width: 1,style: BorderStyle.solid, color: Colors.teal),
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage("assets/user-profile.jpg")
                              )
                          )),
                          SizedBox(width: 30),
                    Expanded(
                                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                        SizedBox(height: 20.0,),
                        Container(width: MediaQuery.of(context).size.width* 0.6, child: Text(userName, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(71, 71, 107, 1.0)),)),
                        SizedBox(height: 5.0,),
                        Container(width: MediaQuery.of(context).size.width * 0.5,child: Text("Jl. Pulau Goreng 1 Blok. h2 No.10", style: TextStyle(fontSize: 18.0, color: Color.fromRGBO(71, 71, 107, 1.0)))),
                        SizedBox(height: 5.0,),
                        Text("081285851690", style: TextStyle(fontSize: 15.0, color: Color.fromRGBO(71, 71, 107, 1.0))),
                      ],),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              //Hospicash
              Center(
                  child: Stack(
                  children: <Widget>[
                    Container(
                      height: 112.00,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Column(
                        children: <Widget>[
                            SizedBox(height: 45.00,),
                            Container(width: MediaQuery.of(context).size.width*0.9 - 30,child: Text("Balance", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Color(0xffffffff),  ),)),
                            Container(
                              width: MediaQuery.of(context).size.width*0.9 - 30,
                              child: Text("Rp. 200.000", textAlign: TextAlign.right, style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color:Color(0xffffffff),  ))
                              )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff44d7b6),
                        boxShadow: [
                            BoxShadow(
                                offset: Offset(0.00,3.00),
                                color: Color(0xff000000).withOpacity(0.16),
                                blurRadius: 6,
                        ),
                       ], borderRadius: BorderRadius.circular(15.00), 
                      ), 
                    ),
                    new Container(
                        height: 34.00,
                        width: MediaQuery.of(context).size.width*0.9,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10.0,),
                            FaIcon(FontAwesomeIcons.wallet, color: Colors.white,),
                            SizedBox(width: 10.0,),
                            Text("Hospicash", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),)
                          ],
                        ),
                        decoration: BoxDecoration(
                        color: Color(0xff39c4a4),
                        boxShadow: [
                        BoxShadow(
                            offset: Offset(0.00,3.00),
                            color: Color(0xff000000).withOpacity(0.16),
                            blurRadius: 6,
                          ),
                        ], borderRadius: BorderRadius.only(topLeft: Radius.circular(15.00), topRight: Radius.circular(15.00), ), 
                      ), 
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              //Account Tab
              Column(
                children: <Widget>[ 
                  Container(width: MediaQuery.of(context).size.width*0.95,child: Text("Account", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22,color:Color(0xff47476b),),textAlign: TextAlign.left,),),
                  ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _iconAccount.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(leading: FaIcon(_iconAccount[index], color: Color(0xff47476b),),
                    title: Text(_titleAccount[index], style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color:Color(0xff47476b),  
                      )),
                      trailing: Icon(Icons.keyboard_arrow_right,)
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(height: 5.0,),
                ),
                ]
              ),
              SizedBox(height: 20.0),
              //Account Tab
              Column(
                children: <Widget>[ 
                  Container(width: MediaQuery.of(context).size.width*0.95,child: Text("General", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22,color:Color(0xff47476b),),textAlign: TextAlign.left,),),
                  ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _iconGeneral.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(leading: FaIcon(_iconGeneral[index], color: Color(0xff47476b),),
                    title: Text(_titleGeneral[index], style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color:Color(0xff47476b),  
                      )),
                      trailing: Icon(Icons.keyboard_arrow_right,)
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(height: 5.0,),
                ),
                ]
              ),
            ],
          ),
        ),
      )
    );
  }
}