import 'dart:math';
import 'package:camera/camera.dart';
import 'package:fingereyeliedetector/UI/FingerprintPlayerOneScreen.dart';
import 'package:fingereyeliedetector/UI/VoiceDetectorScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Resources/ImageResourceas.dart';
import '../Resources/colorResources.dart';
import '../classes/language_constants.dart';
import 'CameraScreen.dart';

class ResultScreen extends StatefulWidget {
  String? voiceDetectScreen;

  ResultScreen({Key? key, this.voiceDetectScreen}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<String> stringList = [];
  List lieImagesList = [
    lie1Img,
    lie2Img,
    lie3Img,
    lie4Img,
  ];
  List trueImagesList = [true1Img, true2Img, true3Img, true4Img];
  String randomString = '';
  Image? randomLieImg;
  Image? randomTrueImg;
  Color containerBorderColor = themeColor;
  Color textColor = themeColor;

  void generateRandomString() {
    Random random = Random();
    int randomIndex = random.nextInt(stringList.length);
    setState(() {
      randomString = stringList[randomIndex];
      if (randomString == translation(context).youLieText) {
        // containerBorderColor = Colors.red;
        // textColor = Colors.red;
        generateRandomLieImg(); // Call the function to generate random lie image
      } else if (randomString == translation(context).youTellTheTruthText) {
        // containerBorderColor = Colors.green;
        // textColor = Colors.green;
        generateRandomTrueImg(); // Call the function to generate random true image
      }
    });
  }

  void generateRandomLieImg() {
    Random random = Random();
    int randomIndex = random.nextInt(lieImagesList.length);
    setState(() {
      randomLieImg = Image.asset(
        lieImagesList[randomIndex],
        width: double.infinity,
        fit: BoxFit.fill,
      );
      randomTrueImg = null; // Reset the true image
    });
  }

  void generateRandomTrueImg() {
    Random random = Random();
    int randomIndex = random.nextInt(trueImagesList.length);
    setState(() {
      randomTrueImg = Image.asset(
        trueImagesList[randomIndex],
        width: double.infinity,
        fit: BoxFit.fill,
      );
      randomLieImg = null; // Reset the lie image
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access context-related data (e.g., translations) here.
    stringList = [
      translation(context).youLieText,
      translation(context).youTellTheTruthText,
    ];
    generateRandomString();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: scaffoldBakGroundColor,
      body: WillPopScope(
        onWillPop: () async {
          if (widget.voiceDetectScreen == 'VoiceDetectScreen') {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return VoiceDetectorScreen();
              },
            ));
          } else if (widget.voiceDetectScreen == 'FingerPlay1') {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return FingerPrintPlayerOne();
              },
            ));
          } else if (widget.voiceDetectScreen == 'CameraScreen') {
            await availableCameras().then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
          }
          return Future.value(false);
        },
        child: SafeArea(
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
                                onPressed: () async {
                                  // Navigator.pop(context);
                                  if (widget.voiceDetectScreen ==
                                      'VoiceDetectScreen') {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return VoiceDetectorScreen();
                                      },
                                    ));
                                  } else if (widget.voiceDetectScreen ==
                                      'FingerPlay1') {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return FingerPrintPlayerOne();
                                      },
                                    ));
                                  } else if (widget.voiceDetectScreen ==
                                      'CameraScreen') {
                                    await availableCameras().then((value) =>
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => CameraPage(
                                                    cameras: value))));
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: themeColor,
                                )),
                            Text(
                              translation(context).eyeDetectorText,
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

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  child: Container(
                    height: 12.h,
                    width: 100.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(eyeStartFrameImg),
                            fit: BoxFit.fill)),
                    child: Center(
                        child: Text(
                      randomString,
                      style: GoogleFonts.russoOne(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: themeColor),
                    )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      // border: Border.all(color: containerBorderColor, width: 4),
                    ),
                    height: 40.h,
                    width: double.infinity,
                    child: Center(
                        child: randomString == translation(context).youLieText
                            ? randomLieImg
                            : randomTrueImg),
                  ),
                ),
               Container(
               height: 10.h,
               ),
               InkWell(
                 onTap: () async {
                   if (widget.voiceDetectScreen == 'VoiceDetectScreen') {
                     Navigator.pushReplacement(context, MaterialPageRoute(
                       builder: (context) {
                         return VoiceDetectorScreen();
                       },
                     ));
                   } else if (widget.voiceDetectScreen == 'FingerPlay1') {
                     Navigator.pushReplacement(context, MaterialPageRoute(
                       builder: (context) {
                         return FingerPrintPlayerOne();
                       },
                     ));
                   } else if (widget.voiceDetectScreen == 'CameraScreen') {
                     await availableCameras().then((value) => Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
                   }
                   return Future.value(false);
                 },
                 child: Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 20.w),
                   child: Container(
                      height: 12.h,
                     decoration:  BoxDecoration(
                         image: DecorationImage(
                             image: AssetImage(resultContainerImg),
                             fit: BoxFit.fill)),
                     child: Center(
                         child: Text(
                           translation(context).reScanText,
                           style: GoogleFonts.russoOne(
                               fontWeight: FontWeight.w600,
                               fontSize: 14.sp,
                               color: themeColor),
                         )),
                   ),
                 ),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
