import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository{
  final FirebaseFirestore _firestore;
  AuthRepository({
    required FirebaseFirestore firestore
}) : _firestore = firestore;
  createUser({
    required UserModel
}){

  }
}