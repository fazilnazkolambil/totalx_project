import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalx_project/Core/constants/const_page.dart';
import 'package:totalx_project/Core/global/utils.dart';

import '../../../Core/global/global_variables.dart';

final radioButtonProvider = StateProvider <String?> ((ref) => '1');
class UserListPage extends ConsumerStatefulWidget {
  const UserListPage({super.key});

  @override
  ConsumerState<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends ConsumerState<UserListPage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
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
                      Center(child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: w * 0.13,
                        backgroundImage: const AssetImage(ImageConst.userIcon),
                      )),
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
                          Container(
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
                          const SizedBox(width: 10,),
                          Container(
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
                                RadioMenuButton(
                                    value: "1",
                                    groupValue: radio,
                                    onChanged: (value) {
                                      ref.read(radioButtonProvider.notifier).update((state) => value);
                                      Navigator.pop(context);
                                    },
                                    child: Text("All",style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: w * 0.04
                                    ))),
                                RadioMenuButton(
                                    value: "2",
                                    groupValue: radio,
                                    onChanged: (value) {
                                      ref.read(radioButtonProvider.notifier).update((state) => value);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Age : Elder",style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: w * 0.04
                                    ))),
                                RadioMenuButton(
                                    value: "3",
                                    groupValue: radio,
                                    onChanged: (value) {
                                      ref.read(radioButtonProvider.notifier).update((state) => value);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Age : Younger",style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: w * 0.04
                                    ))),
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
                height: h * 0.8,
                child: ListView.separated(
                    itemCount: 7,
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
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: w * 0.1,
                            ),
                            SizedBox(width: w * 0.03),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Martin Dokidis',style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: w * 0.035,
                                    color: Colors.black
                                )),
                                Text('Age : 34',style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: w * 0.03,
                                    color: Colors.black
                                ))
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 10,)

                )
              )
            ],
          ),
        ),
      ),
    ));
  }
}
