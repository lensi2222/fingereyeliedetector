import 'package:camera/camera.dart';
import 'package:fingereyeliedetector/UI/FingerprintPlayerTwoScreen.dart';
import 'package:fingereyeliedetector/UI/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Resources/ImageResourceas.dart';
import '../Resources/colorResources.dart';
import '../Resources/stringResources.dart';
import '../classes/language_constants.dart';
import 'CameraScreen.dart';

class EyeDetectorScreen extends StatefulWidget {
  const EyeDetectorScreen({Key? key}) : super(key: key);

  @override
  State<EyeDetectorScreen> createState() => _EyeDetectorScreenState();
}

class _EyeDetectorScreenState extends State<EyeDetectorScreen> {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ));
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: scaffoldBakGroundColor,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(backGroundImg), fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  // height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return  HomeScreen();
                                    },
                                  ));
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: themeColor,
                                )),
                            Text(
                              translation(context). eyeDetectorText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: themeColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 3.h,horizontal: 8.w),
                  child: Image.asset(faceScanningImg),
                ),
                GestureDetector(
                  onTap: () async {
                    await availableCameras().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CameraPage(cameras: value))));
                  },
                  child: Container(
                    height: 10.h,
                    width: 70.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(eyeStartFrameImg), fit: BoxFit.fill)),
                    child: Center(
                        child: Text(
                          translation(context). startText,
                      style: GoogleFonts.russoOne(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: themeColor),
                    )),
                  ),
                ),
                Container(
                  height: 3.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
