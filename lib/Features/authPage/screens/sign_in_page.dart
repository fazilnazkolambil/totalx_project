import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:totalx_project/Core/constants/const_page.dart';
import 'package:totalx_project/Core/global/utils.dart';
import 'package:totalx_project/Features/authPage/screens/otp_page.dart';

import '../../../Core/global/global_variables.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: SizedBox(
            height: h * 0.6,
            width: w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: h * 0.2,
                      width: h * 0.2,
                      child: const Image(image: AssetImage(ImageConst.signInImage))),
                ),
                SizedBox(height: h * 0.01,),
                Text('Enter Phone Number ',style: TextStyle(
                  color: ColorConst.textColor,
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w600
                )),
                textField(phoneNumberController, 'Enter Phone Number *',10,text: false),
                RichText(text: TextSpan(
                  style: TextStyle(
                      color: ColorConst.textColor.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                      fontSize: w * 0.03,
                    letterSpacing: w * 0.002
                  ),
                  children: const [
                     TextSpan(
                      text: "By Continuing, I agree to TotalX's ",
                    ),
                    TextSpan(
                      text: 'Terms and Condition ',
                      style: TextStyle(
                        color: Colors.blue
                      )
                    ),
                    TextSpan(
                      text: '& '
                    ),
                    TextSpan(
                      text: 'privacy policy',
                        style: TextStyle(
                            color: Colors.blue
                        )
                    )
                  ]
                )),
                InkWell(
                  onTap: () {
                    if(phoneNumberController.text.isNotEmpty && phoneNumberController.text.length == 10){
                      userNumber = '+91${phoneNumberController.text}';
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpPage()));

                    }else{
                      showErrorToast(context, 'Please enter a valid phone number');
                    }
                  },
                  child: Container(
                      height: w * 0.12,
                      width: w * 0.9,
                      decoration: BoxDecoration(
                        color: ColorConst.secondaryColor,
                        borderRadius:
                        BorderRadius.circular(w * 0.07),
                      ),
                      child: Center(
                          child: Text("Get OTP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: w * 0.04)))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
