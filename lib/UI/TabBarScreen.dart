import 'package:fingereyeliedetector/Resources/stringResources.dart';
import 'package:fingereyeliedetector/UI/EyeDetectorScreen.dart';
import 'package:fingereyeliedetector/UI/FingerprintPlayerOneScreen.dart';
import 'package:fingereyeliedetector/UI/FingerprintPlayerTwoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Resources/ImageResourceas.dart';
import '../Resources/colorResources.dart';
import '../classes/language_constants.dart';

class TabBarScreen extends StatefulWidget {
  int? isSelected;

  TabBarScreen({Key? key, this.isSelected}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      // statusBarColor: Colors.black,
      // statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backGroundImg), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: widget.isSelected == 1
                      ? FingerPrintPlayerOne()
                      : widget.isSelected == 2
                          ? const FingerPrintPlayTwo()
                          : const EyeDetectorScreen()),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.isSelected = 1;
                        });
                      },
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.isSelected == 1
                                    ? navigatorOneImg
                                    : navigatorTwoImg),
                                fit: BoxFit.fill)),
                        child: Center(
                            child: Text(
                              translation(context). playerOneText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: widget.isSelected == 1?themeColor:themeColor.withOpacity(0.5)),
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.isSelected = 2;
                        });
                      },
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.isSelected == 2
                                    ? navigatorOneImg
                                    : navigatorTwoImg),
                                fit: BoxFit.fill)),
                        child: Center(
                            child: Text(
                              translation(context).playerTwoText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: widget.isSelected == 2?themeColor:themeColor.withOpacity(0.5)),
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.isSelected = 3;
                        });
                      },
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.isSelected == 3
                                    ? navigatorOneImg
                                    : navigatorTwoImg),
                                fit: BoxFit.fill)),
                        child: Center(
                            child: Text(
                              translation(context).eyeDetectorText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: widget.isSelected == 3?themeColor:themeColor.withOpacity(0.5)),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
