import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospiqueue/models/hospital.dart';
import 'package:hospiqueue/models/doctor.dart';
import 'package:hospiqueue/screens/wrapper.dart';
import 'package:hospiqueue/shared/loading.dart';

final List<Hospital> _hospitals = [
  Hospital(name: "Kembangan Hospital",address: "Jalan Bersalin 20, Jakarta Barat", rating: 4.5, distance: 2),
  Hospital(name: "Cinta Kasih Hospital", address: "Jalan Daan Mogot 7, Jakarta Barat", rating: 4.2, distance: 3.6),
  Hospital(name: "Senayan Hospital", address: "Jalan Senayan 5, Jakarta Pusat", distance: 6.1, rating: 4.7),
  Hospital(name: "Hasada Hospital", address: "Jalan Hasada 11, Jakarta Barat", distance: 6.1, rating: 4.1)
];

final List<Doctor> _doctors = [
  Doctor(name: "Sunardi Muranda", specialist: "Eye", queue: 75, monday: "07.00 AM - 03.00 PM", tuesday: "07.00 AM - 03.00 PM",wednesday: "11.00 AM - 05.00 PM", thursday: "07.00 AM - 03.00 PM", friday: "01.00 PM - 10.00 PM", saturday: "07.00 AM - 03.00 PM", sunday: "Not Available", image: "SunardiMuranda", curQueue: 92),
  Doctor(name: "Jennifer", specialist: "Children", queue: 60, monday: "11.00 AM - 07.00 PM", tuesday: "11.00 AM - 07.00 PM",wednesday: "11.00 AM - 07.00 PM", thursday: "Not Available", friday: "Not Available", saturday: "01.00 PM - 10.00 PM", sunday: "Not Available", image: "Jennifer", curQueue: 72),
  Doctor(name: "Kenny Soetopo", specialist: "Children", queue: 40, monday: "11.00 AM - 07.00 PM", tuesday: "11.00 AM - 07.00 PM",wednesday: "11.00 AM - 07.00 PM", thursday: "11.00 AM - 07.00 PM", friday: "11.00 AM - 07.00 PM", saturday: "Not Available", sunday: "11.00 AM - 03.00 PM", image: "KennySoetopo", curQueue: 44),
  Doctor(name: "Shanice", specialist: "Heart", queue: 66, monday: "08.00 AM - 11.00 AM", tuesday: "09.00 AM - 01.00 PM",wednesday: "11.00 AM - 05.00 PM", thursday: "11.00 AM - 02.00 PM", friday: "10.00 AM - 03.00 PM", saturday: "Not Available", sunday: "07.00 AM - 03.00 PM", image: "Shanice", curQueue: 69)
];
var weekday;
List <Doctor> _unavailableDoctors = [];
List <Doctor> _availableDoctors = [];
var date = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

var userName;

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var isLoading = true;
  inputData() async {
    setState(() {
      isLoading = true;
    });
    do{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    userName = user.displayName;
    }while(userName == null);
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
    return userName == null ? Loading() : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              color: Colors.transparent, 
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
                child: Stack(
                  children:<Widget>[Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 10.0,),
                      FaIcon(FontAwesomeIcons.search, color: Color(0xff8693c1),),
                      SizedBox(width: 5.0,),
                      Text("Find The Nearest Hospital", style: TextStyle(
    fontSize: 16,
      color:Color(0xff8693c1),  
  ))
                    ],
                  ),
              ),]
                ),
            ),),
            Stack(children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(aspectRatio: 10 / 3),
                items: ["Carousel-1.png","Carousel-2.jpg"].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image(image: AssetImage("assets/" + i),)
                      );
                    },
                  );
                }).toList(),
              )
            ],),
            Expanded(flex: 1,
                          child: Container(color: Colors.white, child: Column(children: <Widget> [SizedBox(height: 10.0),
              Center(child: Text("Good Morning", style: TextStyle(
      fontWeight: FontWeight.w700,
    fontSize: 30,
      color:Color(0xff47476b), 
              ))),
              Center(child: new Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: new BoxDecoration(
                            border: Border.all(width: 1,style: BorderStyle.solid, color: Colors.teal),
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage("assets/user-profile.jpg")
                              )
                          )),),
              Center(child: Text(userName, style: TextStyle(
      fontFamily: "Open Sans",fontWeight: FontWeight.w700,
    fontSize: 30,
      color:Color(0xff47476b),  
  ),),),
          Center(child: Text("Jl. Pulau Goreng 1 Blok. h2 No.10", style: TextStyle(
      fontFamily: "Open Sans",
    fontSize: 20,
      color:Color(0xff47476b),  
  )),),
          Center(child: Text("081285851690", style: TextStyle(
      fontFamily: "Open Sans",
    fontSize: 20,
      color:Color(0xff47476b),  
  )),)
              ],
        ),
      ),
            )
          ]));
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(68, 215, 182, 1.0),
        title: GestureDetector(
          onTap: (){
            showSearch(context: context, delegate: HospitalSearch());
          },
                  child: Stack(
                    children:<Widget>[Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white),
                    width: MediaQuery.of(context).size.width - 10,
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.search),
                        Text("Find The Nearest Hospital", style: TextStyle(
    fontSize: 16,
      color:Color(0xff8693c1),  
  ))
                      ],
                    ),
                ),]
                  ),
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            GestureDetector(
              onTap: (){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TopRatedRoute()),
                );
              },
                          child: new Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.award, color: Color.fromRGBO(255, 181, 84, 1.0),size: MediaQuery.of(context).size.width*0.2,),
                    SizedBox(height: 5.0),
                    Text("Top Rated", style: TextStyle(
    fontSize: 18,
      color:Color(0xff47476b),  
  ))
                  ],
                ),
        height: MediaQuery.of(context).size.width*0.4,
    width: MediaQuery.of(context).size.width*0.4,
        decoration: BoxDecoration(
        color: Color(0xffffffff),
border: Border.all(width: 1.00, color: Color.fromRGBO(112, 112, 112, 0.5),), 
    boxShadow: [
        BoxShadow(
              offset: Offset(0.00,3.00),
              color: Color(0xff000000).withOpacity(0.16),
blurRadius: 6,
    ),
  ], borderRadius: BorderRadius.circular(15.00), 
    ), 
    ),
            ),
    GestureDetector(
      onTap: (){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MostVisitedRoute()),
                );
              },
          child: new Container(
        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.walking, color: Color.fromRGBO(18, 193, 213, 1.0),size: MediaQuery.of(context).size.width*0.2,),
                    SizedBox(height: 5.0),
                    Text("Most Visited", style: TextStyle(
      fontSize: 18,
        color:Color(0xff47476b),  
  ))
                  ],
                ),
          height: MediaQuery.of(context).size.width*0.4,
    width: MediaQuery.of(context).size.width*0.4,
          decoration: BoxDecoration(
          color: Color(0xffffffff),
border: Border.all(width: 1.00, color: Color.fromRGBO(112, 112, 112, 0.5),), 
      boxShadow: [
          BoxShadow(
              offset: Offset(0.00,3.00),
              color: Color(0xff000000).withOpacity(0.16),
blurRadius: 6,
      ),
  ], borderRadius: BorderRadius.circular(15.00), 
      ), 
      ),
    )
          ],),
          SizedBox(height: 30.0),
          //Near Me
          Expanded(
                      child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.9 ,
                      child: Text("Near Me",style: TextStyle(
                          fontFamily: "Open Sans",fontWeight: FontWeight.w700,
                        fontSize: 21,
                          color:Color(0xffffffff),  
                      ),),
                    ),
                    SizedBox(height: 10.0,),
                    Image.asset("assets/Map.png", width: MediaQuery.of(context).size.width,),
                    Expanded(
                        child: Container(
                        height: 500.0,
                        color: Colors.white,
                        child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: _hospitals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: (){
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HospitalDetailScreen(hospital: _hospitals[index]),
                              ),);
                            },
                            leading: FaIcon(FontAwesomeIcons.mapMarker, color: Color(0xff47476b),),
                          title: Text(_hospitals[index].name, style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color:Color(0xff47476b),  
                            )),
                            subtitle: Text(_hospitals[index].address,style: TextStyle(fontSize: 15,color:Color(0xff47476b),) ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(height: 5.0,),
                  ),
                      ),
                    ),
                  ],
                ),
    width:  MediaQuery.of(context).size.width,
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
    ),
          ),
        ]),
      ),
    );
  }
}

class TopRatedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(68, 215, 182, 1.0),
        title: Text("Top Rated"),
      ),
      body: Container(
        child: Container(
                      height: 500.0,
                      color: Colors.white,
                      child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: _hospitals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HospitalDetailScreen(hospital: _hospitals[index]),
                            ),);
                          },
                          leading: FaIcon(FontAwesomeIcons.mapMarker, color: Color(0xff47476b),),
                        title: Text(_hospitals[index].name, style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color:Color(0xff47476b),  
                          )),
                          subtitle: Text(_hospitals[index].address,style: TextStyle(fontSize: 15,color:Color(0xff47476b),) ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 5.0,),
                ),
                    ),
      )
    );
  }
}

class MostVisitedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(68, 215, 182, 1.0),
        title: Text("Most Visited"),
      ),
      body: Container(
        child: Container(
                      height: 500.0,
                      color: Colors.white,
                      child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: _hospitals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HospitalDetailScreen(hospital: _hospitals[index]),
                            ),);
                          },
                          leading: FaIcon(FontAwesomeIcons.mapMarker, color: Color(0xff47476b),),
                        title: Text(_hospitals[index].name, style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color:Color(0xff47476b),  
                          )),
                          subtitle: Text(_hospitals[index].address,style: TextStyle(fontSize: 15,color:Color(0xff47476b),) ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 5.0,),
                ),
                    ),
      )
    );
  }
}

class HospitalDetailScreen extends StatelessWidget {
  final Hospital hospital;

  HospitalDetailScreen({Key key, @required this.hospital}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    fillList();
    return Scaffold(
      extendBodyBehindAppBar: true,
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
              child: Column(
                children: <Widget> [Container(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image(image: AssetImage('assets/hospitalPhoto.jpg'),fit: BoxFit.fill,))
            ),
              Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, left: MediaQuery.of(context).size.width*0.04, right: MediaQuery.of(context).size.width*0.04),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Container(width: MediaQuery.of(context).size.width*0.8,child: Text(hospital.name, style: TextStyle(fontWeight: FontWeight.w700,fontSize: MediaQuery.of(context).size.width*0.07,color:Color(0xff47476b),))),
                          Container(width: MediaQuery.of(context).size.width*0.8, child: Text(hospital.address, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),),))
                        ],),
                        FaIcon(FontAwesomeIcons.shareAlt, color: Color(0xff47476b),size: MediaQuery.of(context).size.width*0.07,)
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: MediaQuery.of(context).size.width*0.04),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                  FaIcon(FontAwesomeIcons.solidStar, color: Color(0xff47476b), size: 30.0,),
                  SizedBox(width: 10.0),
                  Text(hospital.rating.toString() + " / 5", style: TextStyle(fontSize: 22,color:Color(0xff47476b),))
                ],)
              ),
              SizedBox(height: 30.0,),
              Column(children: <Widget>[
                new Container(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Text("Available Doctor", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Color(0xffffffff),),textAlign: TextAlign.left,)
                      ]
                    ),
                  ),
                    height: 46.00,
                    width: MediaQuery.of(context).size.width,
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
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: _availableDoctors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(leading: CircleAvatar(backgroundImage: AssetImage("assets/" + _availableDoctors[index].image + ".jpg"), radius: 32.0,),
                      onTap: (){
                        showModalBottomSheet(
                          isScrollControlled:true,
                      context: context,
                      builder: (context) => Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height*0.8,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                                                          child: Column(
                                children: <Widget>[
                                  FaIcon(FontAwesomeIcons.bars, color: Colors.grey,),
                                  SizedBox(height: 30.0),
                                   new Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: MediaQuery.of(context).size.width*0.4,
                          decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new AssetImage(
                                        "assets/" + _availableDoctors[index].image + ".jpg")
                                )
                          )),
                          SizedBox(height: 10.0),
                          Text(_availableDoctors[index].name, style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:Color(0xff47476b),)),
                          Text(_availableDoctors[index].specialist + ' Specialist', style: TextStyle(fontSize: 20,color:Color(0xff47476b),)),
                          SizedBox(height: 10),
                          SizedBox(
                              height: 40,
                              width: 250,
                                child: RaisedButton(
                                onPressed: (){
                                    Wrapper.doctorForQueue = _availableDoctors[index];
                                    Wrapper.queue = (_availableDoctors[index].queue);
                                    Wrapper.curQueue = _availableDoctors[index].curQueue;
                                    Wrapper.hospitalForQueue = this.hospital;
                                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                },
                                child: Text('Queue',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Color(0xffffffff),  )),
                                color: Color(0xff44d7b6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Color.fromRGBO(18, 193, 213, 1.0))
                                ),
                              ),
                          ),
                          Text("Current Queue: " + (_availableDoctors[index].curQueue - _availableDoctors[index].queue).toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17,color:Color(0xff47476b),  ) ),
                          SizedBox(height: 20.0,),
                          Card(color: DateTime.now().weekday == 1 ? Color(0xff44d7b6) : Colors.white, child: ListTile(trailing: Text(_availableDoctors[index].monday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 1 ? Colors.white : Color(0xff47476b),)),title: Text("Monday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 1 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 2 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].tuesday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 2 ? Colors.white : Color(0xff47476b),)),title: Text("Tuesday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 2 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 3 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].wednesday, style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: DateTime.now().weekday == 3 ? Colors.white : Color(0xff47476b)),),title: Text("Wednesday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 3 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 4 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].thursday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 4 ? Colors.white : Color(0xff47476b),)),title: Text("Thursday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 4 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 5 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].friday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 5 ? Colors.white : Color(0xff47476b),)),title: Text("Friday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 5 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 6 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].saturday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 6 ? Colors.white : Color(0xff47476b),)),title: Text("Saturday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 6 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 7 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].sunday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 7 ? Colors.white : Color(0xff47476b),)),title: Text("Sunday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 7 ? Colors.white : Color(0xff47476b),)),)),
                                ]
                              ),
                            )
                          ,));
                      },
                      title: Text(_availableDoctors[index].name, style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color:Color(0xff47476b),  
                        )),
                        subtitle: RichText(text: TextSpan(style: TextStyle(color: Color(0xff47476b)),
                        children: <TextSpan> [
                          TextSpan(text: _availableDoctors[index].specialist + ' Specialist\n', style: TextStyle(fontSize: 17,)),
                          TextSpan(text: _availabilitySwitchCase(_availableDoctors[index]), style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,color:Color(0xff47476b),))
                        ],)),
                        trailing: Icon(Icons.keyboard_arrow_right,),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(height: 5.0,),
                  ),
              ],),
              SizedBox(height: 30.0,),
              Column(children: <Widget>[
                new Container(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Text("Unavailable Doctor", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Color(0xffffffff),),textAlign: TextAlign.left,)
                      ]
                    ),
                  ),
                    height: 46.00,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff1f584b),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00,3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                          blurRadius: 6,
                        ),
                      ], borderRadius: BorderRadius.only(topLeft: Radius.circular(15.00), topRight: Radius.circular(15.00), ), 
                    ), 
                  ),
                  Container(
                      color: Colors.grey,
                      child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: _unavailableDoctors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(leading: CircleAvatar(backgroundImage: AssetImage("assets/" + _unavailableDoctors[index].image + ".jpg"), radius: 32.0,),
                        title: Text(_unavailableDoctors[index].name, style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color:Color(0xff47476b),  
                        )),
                        subtitle: RichText(text: TextSpan(style: TextStyle(color: Color(0xff47476b)),
                        children: <TextSpan> [
                          TextSpan(text: _unavailableDoctors[index].specialist + ' Specialist\n', style: TextStyle(fontSize: 17,)),
                          TextSpan(text: _availabilitySwitchCase(_unavailableDoctors[index]), style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,color:Color(0xff47476b),))
                        ],)),
                      );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 5.0,),
                    ),
                  ),
              ],)
              ]
        ),
      ),
    );
  }
}

class HospitalSearch extends SearchDelegate<String>{
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = ThemeData(primaryColor: Color.fromRGBO(68, 215, 182, 1.0));
    assert(theme != null);
    return theme;
  }
  
    @override
   List<Widget> buildActions(BuildContext context) {
     return [
       IconButton(icon: Icon(Icons.clear), onPressed: (){
         query = "";
       },)
     ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
      progress: transitionAnimation),
      onPressed: (){
        close(context, null);
      },);
    }
  
    @override
    Widget buildResults(BuildContext context) {
      if(query != ""){
        return HospitalDetailScreenSearch(hospital: _hospitals.firstWhere((element) => element.name == query),);
      }
      else{
        return buildSuggestions(context);
      }
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      final List <Hospital> suggestionList = query.isEmpty ? _hospitals : _hospitals.where((p) => (p.name).startsWith(query)).toList();
      return ListView.builder(itemBuilder: (context, index)=> ListTile(
        onTap: (){
          this.query = suggestionList[index].name;
          showResults(context);
        },
        leading: FaIcon(FontAwesomeIcons.mapMarkerAlt),
        title: RichText(text: TextSpan(
          text: (suggestionList[index].name).substring(0, query.length),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [TextSpan(
            text: (suggestionList[index].name).substring(query.length),
            style: TextStyle(color: Colors.grey)
          )]
        )),
      ),
      itemCount: suggestionList.length,);
    }
}

void fillList(){
  _unavailableDoctors = [];
  _availableDoctors = [];
  for(var i = 0; i < _doctors.length; i++){
    if(_availabilitySwitchCase(_doctors[i]) == "Not Available"){
      _unavailableDoctors.add(_doctors[i]);
    }
    else{
      _availableDoctors.add(_doctors[i]);
    }
  }
}


class HospitalDetailScreenSearch extends StatelessWidget {
  final Hospital hospital;

  HospitalDetailScreenSearch({Key key, @required this.hospital}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    fillList();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
              child: Column(
                children: <Widget> [Container(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image(image: AssetImage('assets/hospitalPhoto.jpg'),fit: BoxFit.fill,))
            ),
              Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, left: MediaQuery.of(context).size.width*0.04, right: MediaQuery.of(context).size.width*0.04),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Container(width: MediaQuery.of(context).size.width*0.8,child: Text(hospital.name, style: TextStyle(fontWeight: FontWeight.w700,fontSize: MediaQuery.of(context).size.width*0.07,color:Color(0xff47476b),))),
                          Container(width: MediaQuery.of(context).size.width*0.8, child: Text(hospital.address, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color:Color(0xff47476b),),))
                        ],),
                        FaIcon(FontAwesomeIcons.shareAlt, color: Color(0xff47476b),size: MediaQuery.of(context).size.width*0.07,)
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: MediaQuery.of(context).size.width*0.04),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                  FaIcon(FontAwesomeIcons.solidStar, color: Color(0xff47476b), size: 30.0,),
                  SizedBox(width: 10.0),
                  Text(hospital.rating.toString() + " / 5", style: TextStyle(fontSize: 22,color:Color(0xff47476b),))
                ],)
              ),
              SizedBox(height: 30.0,),
              Column(children: <Widget>[
                new Container(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Text("Available Doctor", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Color(0xffffffff),),textAlign: TextAlign.left,)
                      ]
                    ),
                  ),
                    height: 46.00,
                    width: MediaQuery.of(context).size.width,
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
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: _availableDoctors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(leading: CircleAvatar(backgroundImage: AssetImage("assets/" + _availableDoctors[index].image + ".jpg"), radius: 32.0,),
                      onTap: (){
                        showModalBottomSheet(
                          isScrollControlled:true,
                      context: context,
                      builder: (context) => Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height*0.8,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                                                          child: Column(
                                children: <Widget>[
                                  FaIcon(FontAwesomeIcons.bars, color: Colors.grey,),
                                  SizedBox(height: 30.0),
                                   new Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: MediaQuery.of(context).size.width*0.4,
                          decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new AssetImage(
                                        "assets/" + _availableDoctors[index].image + ".jpg")
                                )
                          )),
                          SizedBox(height: 10.0),
                          Text(_availableDoctors[index].name, style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:Color(0xff47476b),)),
                          Text(_availableDoctors[index].specialist + ' Specialist', style: TextStyle(fontSize: 20,color:Color(0xff47476b),)),
                          SizedBox(height: 10),
                          SizedBox(
                              height: 40,
                              width: 250,
                                child: RaisedButton(
                                onPressed: (){
                                    Wrapper.doctorForQueue = _availableDoctors[index];
                                    Wrapper.queue = (_availableDoctors[index].queue);
                                    Wrapper.curQueue = _availableDoctors[index].curQueue;
                                    Wrapper.hospitalForQueue = this.hospital;
                                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                },
                                child: Text('Queue',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Color(0xffffffff),  )),
                                color: Color(0xff44d7b6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Color.fromRGBO(18, 193, 213, 1.0))
                                ),
                              ),
                          ),
                          Text("Current Queue: " + (_availableDoctors[index].curQueue - _availableDoctors[index].queue).toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17,color:Color(0xff47476b),  ) ),
                          SizedBox(height: 20.0,),
                          Card(color: DateTime.now().weekday == 1 ? Color(0xff44d7b6) : Colors.white, child: ListTile(trailing: Text(_availableDoctors[index].monday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 1 ? Colors.white : Color(0xff47476b),)),title: Text("Monday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 1 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 2 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].tuesday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 2 ? Colors.white : Color(0xff47476b),)),title: Text("Tuesday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 2 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 3 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].wednesday, style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: DateTime.now().weekday == 3 ? Colors.white : Color(0xff47476b)),),title: Text("Wednesday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 3 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 4 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].thursday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 4 ? Colors.white : Color(0xff47476b),)),title: Text("Thursday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 4 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 5 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].friday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 5 ? Colors.white : Color(0xff47476b),)),title: Text("Friday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 5 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 6 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].saturday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 6 ? Colors.white : Color(0xff47476b),)),title: Text("Saturday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 6 ? Colors.white : Color(0xff47476b),)),)),
                          Card(color: DateTime.now().weekday == 7 ? Color(0xff44d7b6) : Colors.white,child: ListTile(trailing: Text(_availableDoctors[index].sunday,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:DateTime.now().weekday == 7 ? Colors.white : Color(0xff47476b),)),title: Text("Sunday",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:DateTime.now().weekday == 7 ? Colors.white : Color(0xff47476b),)),)),
                                ]
                              ),
                            )
                          ,));
                      },
                      title: Text(_availableDoctors[index].name, style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color:Color(0xff47476b),  
                        )),
                        subtitle: RichText(text: TextSpan(style: TextStyle(color: Color(0xff47476b)),
                        children: <TextSpan> [
                          TextSpan(text: _availableDoctors[index].specialist + ' Specialist\n', style: TextStyle(fontSize: 17,)),
                          TextSpan(text: _availabilitySwitchCase(_availableDoctors[index]), style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,color:Color(0xff47476b),))
                        ],)),
                        trailing: Icon(Icons.keyboard_arrow_right,),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(height: 5.0,),
                  ),
              ],),
              SizedBox(height: 30.0,),
              Column(children: <Widget>[
                new Container(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Text("Unavailable Doctor", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Color(0xffffffff),),textAlign: TextAlign.left,)
                      ]
                    ),
                  ),
                    height: 46.00,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff1f584b),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00,3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                          blurRadius: 6,
                        ),
                      ], borderRadius: BorderRadius.only(topLeft: Radius.circular(15.00), topRight: Radius.circular(15.00), ), 
                    ), 
                  ),
                  Container(
                      color: Colors.grey,
                      child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: _unavailableDoctors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(leading: CircleAvatar(backgroundImage: AssetImage("assets/" + _unavailableDoctors[index].image + ".jpg"), radius: 32.0,),
                        title: Text(_unavailableDoctors[index].name, style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color:Color(0xff47476b),  
                        )),
                        subtitle: RichText(text: TextSpan(style: TextStyle(color: Color(0xff47476b)),
                        children: <TextSpan> [
                          TextSpan(text: _unavailableDoctors[index].specialist + ' Specialist\n', style: TextStyle(fontSize: 17,)),
                          TextSpan(text: _availabilitySwitchCase(_unavailableDoctors[index]), style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,color:Color(0xff47476b),))
                        ],)),
                      );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 5.0,),
                    ),
                  ),
              ],)
              ]
        ),
      ),
    );
  }
}

String _availabilitySwitchCase(Doctor _switchDoctor,){
  DateTime date = DateTime.now();
  switch(date.weekday){
    case 1:
      return _switchDoctor.monday;
    case 2:
      return _switchDoctor.tuesday;
    case 3:
      return _switchDoctor.wednesday;
    case 4:
      return _switchDoctor.thursday;
    case 5:
      return _switchDoctor.friday;
    case 6:
      return _switchDoctor.saturday;
    case 7:
      return _switchDoctor.sunday;
    default:
      return _switchDoctor.monday;
  }
}