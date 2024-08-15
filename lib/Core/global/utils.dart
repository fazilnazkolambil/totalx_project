import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:totalx_project/Core/constants/const_page.dart';

import 'global_variables.dart';

Widget textField(
   TextEditingController controller,
   String hintText,
    int length,
{
  bool text = true
}
){
  return TextFormField(
    controller: controller,
    keyboardType: text ? TextInputType.text:TextInputType.number,
    inputFormatters: text ? null : <TextInputFormatter>
    [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      FilteringTextInputFormatter.digitsOnly
    ],
    maxLength: length,
    decoration: InputDecoration(
      counterText: '',
      hintText: hintText,
      hintStyle: TextStyle(
        color: ColorConst.textColor.withOpacity(0.5),
        fontSize: w * 0.035
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(w * 0.03),
        borderSide: BorderSide(
          color: ColorConst.textColor.withOpacity(0.1)
        )
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.03),
          borderSide: BorderSide(
              color: ColorConst.textColor.withOpacity(0.5)
          )
      )
    ),
  );
}

void showErrorToast(BuildContext context, String message) {
  MotionToast.error(
      title: Text(
        'Error !',
      ),
      enableAnimation: true,
      position: MotionToastPosition.center,
      description: Text(message))
      .show(context);
}

void showSuccessToast(BuildContext context, String message) {
  MotionToast.success(
      title: Text(
        'Success !',
      ),
      enableAnimation: true,
      position: MotionToastPosition.center,
      description: Text(message))
      .show(context);
}

setSearchParam(String caseNumber) {
  List<String> caseSearchList = [];
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }
  return caseSearchList;
}