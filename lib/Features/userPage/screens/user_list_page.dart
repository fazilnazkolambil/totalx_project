import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx_project/Core/constants/const_page.dart';
import 'package:totalx_project/Core/global/utils.dart';
import 'package:totalx_project/Features/userPage/controller/user_controller.dart';
import 'package:totalx_project/Models/user_model.dart';

import '../../../Core/global/global_variables.dart';

final radioButtonProvider = StateProvider <int?> ((ref) => 0);

class UserListPage extends ConsumerStatefulWidget {
  const UserListPage({super.key});

  @override
  ConsumerState<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends ConsumerState<UserListPage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String userImage = '';
  var file;
  List sortItems = ['All', 'Age : Elder', 'Age : Younger'];
  List <UserModel> filteredItems = [];


  pickFile(ImageSource) async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource);
    file = File(imageFile!.path);
    if (mounted) {
      setState(() {
        file = File(imageFile.path);
      });
      uploadFile();
    }
  }

  uploadFile() async {
    if (file != null) {
      var uploadTask = await FirebaseStorage.instance
          .ref('images')
          .child("${DateTime.now()}")
          .putFile(file!, SettableMetadata(contentType: 'image/jpeg'));
      userImage = await uploadTask.ref.getDownloadURL();
      setState(() { });
    }
  }
  @override
  Widget build(BuildContext context) {
    final radio = ref.watch(radioButtonProvider);
    return SafeArea(child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isDismissible: false,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return SingleChildScrollView(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.03),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(
                          bottom : MediaQuery.of(context).viewInsets.bottom,
                          left : w * 0.03,
                          right: w * 0.03,
                          top: w * 0.03,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Add A New User',style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: w * 0.04,
                                color: Colors.black
                            )),
                            const SizedBox(height: 10),
                            // loading ? CircularProgressIndicator():
                            InkWell(
                                onTap: () {
                                  pickFile(ImageSource.camera);
                                },
                                child: file != null?
                                Center(child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: w * 0.13,
                                  backgroundImage: FileImage(file),
                                )):
                                Center(child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: w * 0.13,
                                  backgroundImage: const AssetImage(ImageConst.userIcon),
                                ))
                            ),
                            const SizedBox(height: 20),
                            const Text('Name'),
                            const SizedBox(height: 10),
                            textField(nameController, 'Enter the Name',99),
                            const SizedBox(height: 20),
                            const Text('Age'),
                            const SizedBox(height: 10),
                            textField(ageController, 'Enter the Age',3,text: false),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    nameController.clear();
                                    ageController.clear();
                                    userImage = '';
                                    file = null;
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: h * 0.04,
                                    width: w * 0.3,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(w * 0.02)
                                    ),
                                    child: const Center(
                                      child: Text('Cancel',style: TextStyle(
                                          color: ColorConst.textColor,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                InkWell(
                                  onTap: () async {
                                    if(file == null){
                                      showErrorToast(context, 'Please upload an Image');
                                    } else if(nameController.text.isEmpty){
                                      showErrorToast(context, 'Please enter name');
                                    } else if(ageController.text.isEmpty){
                                      showErrorToast(context, 'Please enter age');
                                    }else if(int.parse(ageController.text) == 0){
                                      showErrorToast(context, 'Please enter a valid age');
                                    } else {
                                      var users = await FirebaseFirestore.instance.collection(FirebaseConstance.users).get();
                                      String customId = 'User${users.docs.length}';
                                      DocumentReference reference = FirebaseFirestore.instance.collection(FirebaseConstance.users).doc(customId);
                                      UserModel data = UserModel(
                                          name: nameController.text.trim(),
                                          age: int.parse(ageController.text),
                                          number: userNumber,
                                          image: userImage,
                                          reference: reference,
                                          search: setSearchParam(nameController.text)
                                      );
                                      ref.watch(userControllerProvider.notifier).createUser(reference: reference, data: data, context: context);
                                      userImage = '';
                                      file = null;
                                      nameController.clear();
                                      ageController.clear();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    height: h * 0.04,
                                    width: w * 0.3,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(w * 0.02)
                                    ),
                                    child: const Center(
                                      child: Text('Save',style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        )
                    ),
                  );
                },
              );
            },
          );
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Center(child: Icon(CupertinoIcons.add,color: Colors.white,)),
      ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(CupertinoIcons.location_solid,color: Colors.white,),
            Text('Nilambur',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600
            ))
          ],
        ),
        leadingWidth: w * 0.3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: w * 0.8,
                    height: h * 0.06,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() { });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(w * 0.03),
                        prefixIcon: const Icon(CupertinoIcons.search),
                        hintText: 'search by name',
                        hintStyle: TextStyle(
                          fontSize: w * 0.04
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(w * 0.1),
                          borderSide: BorderSide(
                            color: ColorConst.textColor.withOpacity(0.1)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w * 0.1),
                              borderSide: const BorderSide(
                                  color: ColorConst.textColor
                          )
                        )
                      )
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: h * 0.3,
                            padding: EdgeInsets.all(w * 0.03),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: Colors.white
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sort',style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: w * 0.045
                                )),
                                Expanded(
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return RadioMenuButton(
                                            value: index,
                                            groupValue: radio,
                                            onChanged: (value) {
                                              ref.read(radioButtonProvider.notifier).update((state) => index);
                                              print(filteredItems);
                                              Navigator.pop(context);
                                            },
                                            child: Text(sortItems[index],style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: w * 0.04
                                            )));
                                      },
                                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                                      itemCount: sortItems.length
                                  ),
                                )
                              ],
                            ),
                          )
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.02),
                        color: Colors.black
                      ),
                        child: const Icon(Icons.sort_sharp,color: Colors.white,)),
                  )
                ],
              ),
              SizedBox(height: w * 0.03),
              Text('Users Lists',style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: w * 0.04
              )),
              SizedBox(height: w * 0.03),
          SizedBox(
              height: h * 0.75,
              child:
              ref.watch(getUserStream(searchController.text.trim())).when(
                data: (data) {
                  filteredItems = [];
                  radio == 1
                      ? filteredItems.addAll(data.where((element) => element.age! >= 60))
                      : radio == 2
                  ? filteredItems.addAll(data.where((element) => element.age! < 60))
                      : filteredItems.addAll(data);
                  return filteredItems.isEmpty?
                  const Center(child: Text("No added Users"))
                      : ListView.separated(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: h * 0.1,
                          padding: EdgeInsets.all(w * 0.02),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(w * 0.02),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                )
                              ]
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: w * 0.1,
                                  backgroundImage: NetworkImage(filteredItems[index].image.toString()),
                                ),
                                SizedBox(width: w * 0.03),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(filteredItems[index].name.toString().trim(),style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: w * 0.035,
                                        color: Colors.black
                                    )),
                                    Text('Age : ${filteredItems[index].age}',style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: w * 0.03,
                                        color: Colors.black
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 10,)

                  );
                },
                error: (error, stackTrace) {
                  print(error);
                  return Center(child: Text('Something went wrong : $error'));
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              )
          ),
            ],
          ),
        ),
      ),
    ));
  }
}
