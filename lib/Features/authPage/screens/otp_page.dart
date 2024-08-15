import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:totalx_project/Features/userPage/screens/user_list_page.dart';

import '../../../Core/constants/const_page.dart';
import '../../../Core/global/global_variables.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController pin_controller = TextEditingController();
  Timer? _timer;
  int _seconds = 59;
  bool end = false;
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
          end = true;
        }
      });
    });
  }
  @override
  void initState() {
    startTimer();
    super.initState();
  }
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
                      child: const Image(image: AssetImage(ImageConst.otpImage))),
                ),
                SizedBox(height: h * 0.01,),
                Text('OTP Verification',style: TextStyle(
                    color: ColorConst.textColor,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w600
                )),
                Text('Enter the verification code we just sent to your number +91*******${userNumber.substring(7,9)}',style: TextStyle(
                  fontSize: w * 0.035,
                  color: ColorConst.textColor,
                  fontWeight: FontWeight.w400
                )),
                FractionallySizedBox(
                  child: Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    controller:pin_controller,
                    length: 6,
                    submittedPinTheme: PinTheme(
                        height: w * 0.13,
                        width: w * 0.13,
                        textStyle: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorConst.textColor),
                            borderRadius: BorderRadius.circular(w * 0.03)
                        )
                    ),
                    defaultPinTheme: PinTheme(
                      height: w * 0.13,
                      width: w * 0.13,
                      textStyle: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConst.textColor.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(w * 0.03)
                      )
                    ),
                  ),
                ),
                end
                ? const SizedBox()
                : Center(child: Text('$_seconds sec',style: TextStyle(
                  fontSize: w * 0.03,
                  fontWeight: FontWeight.w600,
                  color: Colors.red
                ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("Don't Get OTP? ",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: w * 0.035
                    ),),
                    InkWell(
                      onTap: () {

                      },
                      child: Text('Resend',style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: w * 0.035,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue
                      )),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserListPage()));
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
                          child: Text("Verify",
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
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
