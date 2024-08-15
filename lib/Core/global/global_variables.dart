import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var w;
var h;

String userNumber = '';

final firestoreProvider = Provider ((ref)=> FirebaseFirestore.instance);

class FirebaseConstance{
 static const users = 'users';
}