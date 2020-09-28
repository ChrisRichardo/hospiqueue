import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:hospiqueue/screens/wrapper.dart';

final GlobalKey qrKey = GlobalKey();

class Queue extends StatefulWidget {
  @override
  _QueueState createState() => _QueueState();
}

class _QueueState extends State<Queue> {
  @override
  Widget build(BuildContext context) {
    if(Wrapper.doctorForQueue == null){
      return Container(
  color: Color.fromRGBO(68, 215, 182, 1.0),
  child: Container(
    width: MediaQuery.of(context).size.width,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FaIcon(FontAwesomeIcons.laugh, color: Colors.white, size: 100),
                      Text("You Are Not\nIn Queue", style: TextStyle(
      fontFamily: "Open Sans",fontWeight: FontWeight.w700,
    fontSize: 70,
      color:Color(0xffffffff),  
  ),textAlign: TextAlign.center,),
                      ],
      ),
  ),
);
    }
    else if(Wrapper.curQueue == Wrapper.queue){
      return userTurnBody(context);
    }
    return Container(
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
                  Container(
                  color: Color.fromRGBO(68, 215, 182, 1.0),
                  child: Column(
                    children: <Widget>[
                    SizedBox(height: 5.0,),
                    new Container(
                      width: 240.0,
                      height: 240.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new AssetImage("assets/" + Wrapper.doctorForQueue.image + ".jpg")
                          )
                      )),
                      SizedBox(height: 10.0),
                    Text('Doctor Sunardi Muranda', style: TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 25,
                          color:Color(0xffffffff),  
                      )),
                    Text('Eye Doctor', style: TextStyle(fontSize: 19,
                        color:Color(0xffffffff),  
                    )),
                    SizedBox(height: 20.0,)
                    ]
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                        child: Column(children: <Widget>[
                          SizedBox(height: 10.0,),
                          Text('Your Queue', style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 48,
                              color:Color(0xff47476b),  
                          )),
                          Text(Wrapper.curQueue.toString(), style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 98,
                              color:Color(0xff47476b),  
                          )),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                Wrapper.queue = Wrapper.queue + 1;
                              });
                            },
                                child: Text('Current Queue: ' + Wrapper.queue.toString(), style: TextStyle(fontWeight: FontWeight.w700,
                              fontSize: 28,
                                color:Color(0xff47476b),  
                            )),
                          ),
                          SizedBox(
                            width: Wrapper.curQueue - Wrapper.queue < 5 ? 250.0 : 150.0,
                            child: Wrapper.curQueue - Wrapper.queue < 5 ? qrButton(context) : cancelButton()
                          ),
                          SizedBox(height: 10.0)
                        ],),
                      ),
                    )
                  ]
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(68, 215, 182, 1.0),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.00), topRight: Radius.circular(15.00)),
                        ),
                        child: Column(children: <Widget>[
                          new Container(
                                child: Container(child: Column(children: <Widget> [
                                  SizedBox(height: 10.0),
                                  Text("Destination",style: TextStyle(fontWeight: FontWeight.w700,
    fontSize: 20,
      color:Color(0xffffffff),  
  ))],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                )
                                ,color: Colors.transparent, ),
                                height: 46.00,
                                width: 900.0,
                                decoration: BoxDecoration(
                                color: Color(0xff44d7b6),
                            boxShadow: [
                                BoxShadow(
                                    offset: Offset(0.00,3.00),
                                    color: Color(0xff000000).withOpacity(0.16),
                        blurRadius: 6,
                            ),
                          ], borderRadius: BorderRadius.only(topLeft: Radius.circular(15.00), topRight: Radius.circular(15.00), ), 
                            ), 
                            ),
                            AspectRatio(
                              aspectRatio: 16 / 9,
                                child: Image(
                                image: AssetImage('assets/Map.png'), fit: BoxFit.cover,
                              ),
                            )
                        ],),
                        ),
                    )
                  ],
                ),
            ],
      ),
        ),
    );
  }

    Widget userTurnBody(context) => Container(
    color: Color.fromRGBO(68, 215, 182, 1.0),
    child: SingleChildScrollView(
      child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[SizedBox(height: 5.0,),
                        new Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: MediaQuery.of(context).size.width*0.4,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage("assets/" + Wrapper.doctorForQueue.image + ".jpg")
                              )
                          )),
                          SizedBox(height: 10.0),
                        Text('Doctor Sunardi Muranda', style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 25,
                              color:Color(0xffffffff),  
                          )),
                        Text('Eye Doctor', style: TextStyle(fontSize: 19,
                            color:Color(0xffffffff),  
                        )),
                        SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                        Text("It's Your Turn!", style: TextStyle(
        fontFamily: "Open Sans",fontWeight: FontWeight.w700,
      fontSize: MediaQuery.of(context).size.width*0.08,
        color:Color(0xffffffff),  
    )),
                        Text("Go to", style: TextStyle(
        fontFamily: "Open Sans",fontWeight: FontWeight.w700,
      fontSize: MediaQuery.of(context).size.width*0.06,
        color:Color(0xffffffff),  
    )),
                        Text("Room 25", style: TextStyle(
        fontFamily: "Open Sans",fontWeight: FontWeight.w700,
      fontSize: MediaQuery.of(context).size.width*0.08,
        color:Color(0xffffffff),  
    )),
                        Text("Floor 2F", style: TextStyle(
        fontFamily: "Open Sans",fontWeight: FontWeight.w700,
      fontSize: MediaQuery.of(context).size.width*0.08,
        color:Color(0xffffffff),  
    )),
    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
    SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.height*0.08,
        child: RaisedButton(
        onPressed: (){
        showModalBottomSheet(
          isScrollControlled: true,
            context: context,
            builder: (BuildContext context) => Container(
    color: Colors.white,
    height: MediaQuery.of(context).size.height - 200,
    child: Column(
      children: <Widget>[
        FaIcon(FontAwesomeIcons.bars, color: Colors.grey,),
        SizedBox(height: 20.0),
        Text("Your Session is Done", style: TextStyle(
      fontFamily: "Open Sans",fontWeight: FontWeight.w700,
    fontSize: 32,
      color:Color(0xff47476b),  
  )),
  Text("Scan " + Wrapper.hospitalForQueue.name, style: TextStyle(
      fontFamily: "Open Sans",fontWeight: FontWeight.w700,
    fontSize: 20,
      color:Color(0xff47476b),  
  )),
  Text("Payment QR Code", style: TextStyle(
      fontFamily: "Open Sans",fontWeight: FontWeight.w700,
    fontSize: 20,
      color:Color(0xff47476b),  
  )),
        Expanded(child: QRView(
          key: qrKey, 
        onQRViewCreated: (controller) {
                  controller.scannedDataStream.listen((value) {
                    Navigator.of(context).pop();
                    if(value != null || value != ""){
                      var paymentModalController = showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) => showPayment(context));
                      paymentModalController.whenComplete(() {
                         setState(() {
                          Wrapper.doctorForQueue = null;
                          Wrapper.hospitalForQueue = null;
                        });
                      });
                    }
                    controller.pauseCamera();
                    return;
                  });
        }
        ),),
      ],
    ),
));
      },
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
      side: BorderSide(color: Color.fromRGBO(18, 193, 213, 1.0))
    ),
      color: Color(0xff12c1d5),
      child: Text("Session Done", style: TextStyle(
          fontFamily: "Open Sans",fontWeight: FontWeight.w700,
        fontSize: 21,
          color:Color(0xffffffff),  
      )),),
    ),
    SizedBox(height: 10.0,),
    Text("Press the button when your session is done", style: TextStyle(
        fontFamily: "Open Sans",
      fontSize: 15,
        color:Color(0xffffffff),  
    ))
                        ],
        ),
      ),
    ),
  );

  Widget cancelButton()=>RaisedButton(
  onPressed: (){
    setState(() {
      Wrapper.doctorForQueue = null;
    });
  },
  child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Color(0xffffffff),  )),
  color: Colors.red,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    side: BorderSide(color: Colors.red)
  ),
);

}

Widget qrButton(context)=>RaisedButton(
  onPressed: (){
    showModalBottomSheet(
      isScrollControlled: true,
    context: context,
    builder: (context) => showQrCode(context)
    );
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget> [FaIcon(FontAwesomeIcons.qrcode, color: Colors.white,), 
    SizedBox(width: 10.0,),
    Text('Show QR Code',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Color(0xffffffff),  )),]),
  color: Color.fromRGBO(18, 193, 213, 1.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    side: BorderSide(color: Color.fromRGBO(18, 193, 213, 1.0))
  ),
);

Widget showQrCode(context)=>Container(
    color: Colors.white,
    height: MediaQuery.of(context).size.height*0.8,
    child: Column(
      children: <Widget>[
        FaIcon(FontAwesomeIcons.bars, color: Colors.grey,),
        Image(image: AssetImage("assets/My_Social_Media_Page.png"),width: 400.0,),
        Text("Show your QR Code at", style: TextStyle(
      fontFamily: "Open Sans",
    fontSize: 29,
      color:Color(0xff47476b),  
  )),
        Text(Wrapper.hospitalForQueue.name, style: TextStyle(
      fontFamily: "Open Sans",fontWeight: FontWeight.w700,
    fontSize: 32,
      color:Color(0xff47476b),  
  )),
        Text("Receptionits", style: TextStyle(
      fontFamily: "Open Sans",
    fontSize: 27,
      color:Color(0xff47476b),  
  ))
      ],
    ),
);

Widget showPayment(context) => Wrapper.doctorForQueue == null ? Container(child: Text("")) : SingleChildScrollView(
  child:   Container(
  
    height: MediaQuery.of(context).size.height*0.8,
  
    color: Colors.white,
  
    child: SingleChildScrollView(
          child: Column(
  
          children: <Widget>[
  
            FaIcon(FontAwesomeIcons.bars, color: Colors.grey,),
  
            SizedBox(height: 20.0),
  
            Text("Your Payment is Done", style: TextStyle(
  
          fontFamily: "Open Sans",fontWeight: FontWeight.w700,
  
        fontSize: 32,
  
          color:Color(0xff47476b),)),
  
          Row(
  
            children: <Widget>[
  
              new Container(
  
                width: 150.0,
  
                height: 150.0,
  
                decoration: new BoxDecoration(
  
                    shape: BoxShape.circle,
  
                    image: new DecorationImage(
  
                        fit: BoxFit.fill,
  
                        image: AssetImage("assets/" + Wrapper.doctorForQueue.image + ".jpg")
  
                    )
  
                )),
                SizedBox(width: 20.0,),
                Column(children: <Widget>[
                  Text(Wrapper.doctorForQueue.name, style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22,color:Color(0xff47476b),), textAlign: TextAlign.left,),
                  SizedBox(height: 10,),
                  Text(Wrapper.doctorForQueue.specialist + " Specialist", style: TextStyle(fontSize: 18,color:Color(0xff47476b)), textAlign: TextAlign.left,),
                ],
  
                crossAxisAlignment: CrossAxisAlignment.start,)
  
            ],
  
          ),
  
          SizedBox(height: 20,),
  
          new Container(
  
            child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
  
              Text(Wrapper.hospitalForQueue.name, style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30,color:Color(0xffffffff),)),
  
              Text(Wrapper.hospitalForQueue.address, style: TextStyle(fontSize: 17,color:Color(0xffffffff),  )),
  
            ]),
  
            height: 100.00,
  
            width: MediaQuery.of(context).size.width,
  
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
  
          Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),
  
          child: Column(children: <Widget>[
  
          Row(children: <Widget> [Text("Payment Details", style: TextStyle(fontWeight: FontWeight.w700,fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),))]),
  
          Row(children: <Widget>[Text("Price", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),)), Text("Rp. 50.000", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),))],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
  
          Row(children: <Widget>[Text("Tax (5%)", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),)), Text("Rp. 2.000", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),))],mainAxisAlignment: MainAxisAlignment.spaceBetween, ),
  
          Divider(height: 10,),
  
          Row(children: <Widget>[Text("Total", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),)), Text("Rp. 52.500", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),))],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
  
          SizedBox(height: 20),
  
          Row(children: <Widget>[FaIcon(FontAwesomeIcons.wallet, size: MediaQuery.of(context).size.width*0.06,color: Color(0xff47476b)),Text(" Hospicash Balance",style: TextStyle(fontWeight: FontWeight.w700,fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),  ))]),
  
          Row(children: <Widget>[Text("Rp. 200.000 - Rp. 52.500", style: TextStyle(fontWeight: FontWeight.w700,fontSize: MediaQuery.of(context).size.width*0.04,color:Color(0xff47476b),)),Text("=  Rp.147.500", style: TextStyle(fontWeight: FontWeight.w700,fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),))], mainAxisAlignment: MainAxisAlignment.spaceBetween,)      
  
          ],),)
  
          ]),
    ) 
  
  ),
);