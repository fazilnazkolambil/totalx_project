import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totalx_project/Core/constants/const_page.dart';

import 'global_variables.dart';

Widget textField(
   TextEditingController controller,
   String hintText,
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
    maxLength: text ? 99 : 10,
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