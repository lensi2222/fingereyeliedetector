import 'package:fingereyeliedetector/UI/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../CustomWidget/PopupCustomWidget.dart';
import '../CustomWidget/loadingContainer.dart';
import '../Resources/ImageResourceas.dart';
import '../Resources/colorResources.dart';
import '../classes/language_constants.dart';
import 'ResultScreen.dart';

class VoiceDetectorScreen extends StatefulWidget {
  const VoiceDetectorScreen({Key? key}) : super(key: key);

  @override
  State<VoiceDetectorScreen> createState() => _VoiceDetectorScreenState();
}

class _VoiceDetectorScreenState extends State<VoiceDetectorScreen> {
  @override
  bool isLongVisible = false;
  bool isOnTap = false;
  bool isOnTapFinal = false;
  bool showResultDialog = false;
  String _displayText = '';
  int _currentTextIndex = 0;
  bool _shouldRotate = true;
  bool isVisible = false;
  bool isDelayingDialog = false;
int onTapCount = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access context-related data (e.g., translations) here.
    textOptions = [
      translation(context).analyzingText,
      translation(context).scanningYourAnswerText,
      translation(context).computingTheResultsText,
      translation(context).theResultIsReadyText,
    ];
    // generateRandomString();
  }

  List<String> textOptions = [];

  void _rotateText() {
    if (!_shouldRotate) return; // Stop rotation when _shouldRotate is false

    setState(() {
      _displayText = textOptions[_currentTextIndex];
      _currentTextIndex = (_currentTextIndex + 1) % textOptions.length;
    });

    if (_displayText == translation(context).theResultIsReadyText) {
      _showDialog(context);
      setState(() {
        _shouldRotate =
            false; // Stop rotation when "The result is ready..." is displayed
      });
    }

    if (_shouldRotate) {
      Future.delayed(const Duration(seconds: 1), () {
        if (!_shouldRotate)
          return; // Avoid executing delayed task when not needed
        _rotateText();
      });
    }
  }

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () {

          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return  HomeScreen();
            },
          ));
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
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return  HomeScreen();
                                  //   },
                                  // ));
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: themeColor,
                                )),
                            Text(
                              translation(context).voiceDetectorText,
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
                Container(
                    height: 35.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(fingerprintOneImg),
                            fit: BoxFit.fill)),
                    child: Center(
                      child: isOnTap
                          ? Lottie.asset(
                              heartBitGif,
                              height: 20.h,
                              width: 50.w,
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                              child: Center(
                                child: Text(
                                  !isOnTap ? _displayText : "",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.russoOne(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    color: themeColor,
                                  ),
                                ),
                              ),
                            ),
                    )),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: isOnTap
                              ? Image.asset(
                                  loadingRedImg, // Replace with your image path
                                  height: 15.h,
                                  width: 25.w,
                                )
                              : Image.asset(
                                  loadingGreyImg, // Replace with your image path
                                  height: 15.h,
                                  width: 25.w,
                                ),
                        ),
                        ClipOval(
                            child: LoadingContainer(
                          colorList: const [
                            Color(0xFF767676),
                            Color(0xFFEBEBEB),
                          ],
                        )),
                        Container(
                          width: 2.w,
                        ),
                        ClipOval(
                            child: LoadingContainer(
                          colorList: const [
                            Color(0xFF767676),
                            Color(0xFFEBEBEB),
                          ],
                        )),
                        Container(
                          width: 2.w,
                        ),
                        ClipOval(
                            child: LoadingContainer(
                          colorList: const [
                            Color(0xFF767676),
                            Color(0xFFEBEBEB),
                          ],
                        )),
                        Container(
                          width: 2.w,
                        ),
                        ClipOval(
                            child: LoadingContainer(
                          colorList: const [
                            Color(0xFF767676),
                            Color(0xFFEBEBEB),
                          ],
                        )),
                        Container(
                          width: 2.w,
                        ),
                        ClipOval(
                            child: LoadingContainer(
                          colorList: const [
                            Color(0xFF767676),
                            Color(0xFFEBEBEB),
                          ],
                        )),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: isOnTap
                              ? Image.asset(
                                  loadingGreenImg, // Replace with your image path
                                  height: 15.h,
                                  width: 25.w,
                                )
                              : Image.asset(
                                  loadingGreyImg, // Replace with your image path
                                  height: 15.h,
                                  width: 25.w,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if(onTapCount < 2){
                      setState(() {
                        isOnTap = !isOnTap;
                        isDelayingDialog = true; // Start delaying the dialog
                      });
                      if (!isOnTap) {
                        _rotateText();
                      }
                      onTapCount++;
                    }

                  },
                  child: isOnTap
                      ? Lottie.asset(
                          voiceRecorderJson,
                          height: 25.h,
                        )
                      : Image.asset(
                          voiceScanningImg,
                          height: 25.h,
                        ),
                ),
                Container(
                  height: 2.h,
                ),
                Container(
                  child: Text(
                    isOnTap == true
                        ? translation(context).tapToFinishRecordText
                        : translation(context).tapToStartRecordText,
                    style:
                        GoogleFonts.russoOne(fontSize: 14.sp, color: themeColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowDialog(className:  ResultScreen(voiceDetectScreen: 'VoiceDetectScreen',));
      },
    );
  }
}
