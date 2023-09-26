import 'package:fingereyeliedetector/Resources/ImageResourceas.dart';
import 'package:fingereyeliedetector/Resources/stringResources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Resources/colorResources.dart';
import '../classes/language_constants.dart';

class ShowDialog extends StatelessWidget {
  Widget? className;

  ShowDialog({Key? key, this.className}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent.withOpacity(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
                height: 30.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(fingerprintOneImg), fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      translation(context).scanSuccessFullyText,
                      style: GoogleFonts.russoOne(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: themeColor),
                    ),
                    Container(
                      height: 4.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return className!;
                          },
                        ));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(showPopImg), fit: BoxFit.fill)),
                        height: 5.h,
                        width: 30.w,
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context). checkResultText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                  color: themeColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),


    );
  }
}
