import 'package:fingereyeliedetector/Resources/ImageResourceas.dart';
import 'package:fingereyeliedetector/Resources/colorResources.dart';
import 'package:fingereyeliedetector/UI/ExitScreen.dart';
import 'package:fingereyeliedetector/UI/EyeDetectorScreen.dart';
import 'package:fingereyeliedetector/UI/FingerprintPlayerOneScreen.dart';
import 'package:fingereyeliedetector/UI/FingerprintPlayerTwoScreen.dart';
import 'package:fingereyeliedetector/UI/LanguageScreen.dart';
import 'package:fingereyeliedetector/UI/VoiceDetectorScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../classes/language_constants.dart';

class HomeScreen extends StatefulWidget {
  String? selectedLanguageImage;

  HomeScreen({Key? key, this.selectedLanguageImage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(
              builder: (context) {
                return const ExitScreen();
              },
            ));
        // SystemNavigator.pop();
         return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(backGroundImg), fit: BoxFit.fill)),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: themeColor,
                                )),
                            Text(
                              translation(context).lieDetectorText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: themeColor),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const ExitScreen();
                                      },
                                    ));
                              },
                              child: Image.asset(lanChangesImg)),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FingerPrintPlayerOne()
                            // TabBarScreen(isSelected: 1,)
                            ),
                      );
                    },
                    child: Container(
                      height: 15.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(fingerprintContainerImg),
                              fit: BoxFit.fill)),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translation(context).fingerPrintText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: themeColor),
                            ),
                            Text(
                              translation(context).playerOneText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: themeColor),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FingerPrintPlayTwo()
                            // TabBarScreen(isSelected: 2)
                            ),
                      );
                    },
                    child: Container(
                      height: 15.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(fingerprintContainerImg),
                              fit: BoxFit.fill)),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translation(context).fingerPrintText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: themeColor),
                            ),
                            Text(
                              translation(context).playerTwoText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: themeColor),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EyeDetectorScreen()
                            // TabBarScreen(isSelected: 3)
                            ),
                      );
                    },
                    child: Container(
                      height: 15.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(fingerprintContainerImg),
                              fit: BoxFit.fill)),
                      child: Center(
                          child: Text(
                        translation(context).eyeDetectorText,
                        style: GoogleFonts.russoOne(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: themeColor),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VoiceDetectorScreen()
                            // TabBarScreen(isSelected: 3)
                            ),
                      );
                    },
                    child: Container(
                      height: 15.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(fingerprintContainerImg),
                              fit: BoxFit.fill)),
                      child: Center(
                          child: Text(
                        translation(context).voiceDetectorText,
                        style: GoogleFonts.russoOne(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: themeColor),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
