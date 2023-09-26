import 'package:fingereyeliedetector/Resources/stringResources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Resources/ColorResources.dart';
import '../Resources/ImageResourceas.dart';
import 'SplashScreenOne.dart';

class ExitScreen extends StatefulWidget {
  const ExitScreen({Key? key}) : super(key: key);

  @override
  State<ExitScreen> createState() => _ExitScreenState();
}

class _ExitScreenState extends State<ExitScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(backGroundImg), fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    areYouSureToExitText,
                    style: GoogleFonts.russoOne(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: themeColor),
                  ),
                  GestureDetector(
                    onTap: (){
                      SystemNavigator.pop();
                    },
                    child: Container(
                      height: 12.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(fingerprintContainerImg),
                              fit: BoxFit.fill)),
                      child: Center(
                          child: Text(
                            // translation(context).voiceDetectorText,
                            yesText  ,
                            style: GoogleFonts.russoOne(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: themeColor),
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplashScreenOne()

                        ),
                      );

                    },
                    child: Container(
                      height: 12.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(fingerprintContainerImg),
                              fit: BoxFit.fill)),
                      child: Center(
                          child: Text(
                            // translation(context).voiceDetectorText,
                            noText,
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
