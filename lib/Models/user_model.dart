import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel{
  String? name;
  int? age;
  String? number;
  String? image;
  DocumentReference? reference;
  List? search;

  UserModel({
    required this.name,
    required this.age,
    required this.number,
    required this.image,
    required this.reference,
    required this.search
});
  UserModel copyWith({
    String? name,
    int? age,
    String? number,
    String? image,
    DocumentReference? reference,
    List? search,
}){
    return UserModel(
        name: name ?? this.name,
        age: age ?? this.age,
        number: number ?? this.number,
        image: image ?? this.image,
        reference: reference ?? this.reference,
        search: search ?? this.search
    );
  }
  factory UserModel.fromMap(Map <String, dynamic> map) => UserModel(
      name: map['name'],
      age: map['age'],
      number: map['number'],
      image: map['image'],
      reference: map['reference'],
      search: map['search']
  );
Map <String, dynamic> toMap()=>{
  'name' : name,
  'age' : age,
  'number' : number,
  'image' : image,
  'reference' : reference,
  'search' : search
};
}