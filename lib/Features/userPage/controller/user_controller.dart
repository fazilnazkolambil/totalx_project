import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalx_project/Core/global/utils.dart';
import 'package:totalx_project/Features/userPage/repository/user_repository.dart';

import '../../../Models/user_model.dart';

final userControllerProvider = NotifierProvider <UserController,bool> ((){
  return UserController();
  });
final getUserStream = StreamProvider.autoDispose.family <List<UserModel>,String> ((ref,search){
  return ref.watch(userControllerProvider.notifier).getUsers(search);
});

class UserController extends Notifier <bool> {
  @override
  bool build() {
    // TODO: implement build
    return false;
  }
  Stream <List<UserModel>> getUsers(String search){
    return ref.watch(userRepositoryProvider).getUsers(search);
  }

  createUser({
    required DocumentReference reference,
    required UserModel data,
    required BuildContext context
}){
    var res =  ref.watch(userRepositoryProvider).createUser(reference: reference, data: data);
    res.fold(
        (l) => showErrorToast(context, l.message),
        (r) => showSuccessToast(context,'User added successfully')
    );
  }
}