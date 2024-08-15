import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalx_project/Core/global/global_variables.dart';
import 'package:totalx_project/Models/user_model.dart';

final userRepositoryProvider = Provider((ref) => UserRepository(firestore: ref.watch(firestoreProvider)));

class UserRepository{
  final FirebaseFirestore _firestore;
  UserRepository({
    required FirebaseFirestore firestore
}) : _firestore = firestore;
  CollectionReference get _users => _firestore.collection(FirebaseConstance.users);

  Stream <List<UserModel>> getUsers(String search){
    return _users.where('search',arrayContains: search.isEmpty?null:search.toUpperCase())
        .snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data() as Map <String,dynamic>)).toList());
  }

  createUser({
    required DocumentReference reference,
    required UserModel data,
}) async {
    try{
      return reference.set(data.toMap());
    }on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return e.toString();
    }
  }
}