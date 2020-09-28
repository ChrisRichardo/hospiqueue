import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final CollectionReference doctorCollection = Firestore.instance.collection("doctors");
  
}