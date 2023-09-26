import 'dart:async';
import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fingereyeliedetector/CustomWidget/PopupCustomWidget.dart';
import 'package:fingereyeliedetector/CustomWidget/loadingContainer.dart';
import 'package:fingereyeliedetector/Resources/colorResources.dart';
import 'package:fingereyeliedetector/Resources/stringResources.dart';
import 'package:fingereyeliedetector/UI/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:vibration/vibration.dart';
import '../Resources/ImageResourceas.dart';
import '../classes/language_constants.dart';
import 'ResultScreen.dart';

class FingerPrintPlayerOne extends StatefulWidget {
  int? isSelected;

  FingerPrintPlayerOne({Key? key, this.isSelected}) : super(key: key);

  @override
  State<FingerPrintPlayerOne> createState() => _FingerPrintPlayerOneState();
}

class _FingerPrintPlayerOneState extends State<FingerPrintPlayerOne>
    with TickerProviderStateMixin {
  FlutterGifController? controller;
  Timer? _timer;
  Timer? _timerTemp;
  bool isVibrating = false;
  bool vibrated = true;
  bool audioIcon = true;
  String text = fingerPrintOneText;
  bool isVisible = false;
  bool isLongVisible = false;
  int _currentTextIndex = 0;
  int _currentImagesIndex = 0;
  List<String> textOptions = [];
  List imagesOptions = [
    loadingGreyImg,
    loadingRedImg,
    loadingGreyImg,
    loadingRedImg
  ];
  bool audioPlayer = true;
  bool oneTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    textOptions = [
      translation(context).analyzingText,
      translation(context).scanningYourAnswerText,
      translation(context).computingTheResultsText,
      translation(context).theResultIsReadyText,
    ];
    // generateRandomString();
  }

  String _displayText = '..';
  String displayImages = loadingGreyImg;
  bool _shouldRotate = true;
  bool firstLoadingImg = false;
  bool secLoadingImg = false;
  bool Rotate = false;
  bool imagesLoaded = false;

  void _rotateText() {
    setState(() {
      Rotate = true;
      if (!_shouldRotate) return; // Stop rotation when _shouldRotate is false

      _currentTextIndex = (_currentTextIndex + 1) % textOptions.length;
      _displayText = textOptions[_currentTextIndex];

      if (_displayText == translation(context).theResultIsReadyText) {
        _showDialog(context);
        _shouldRotate = false; // Stop rotation when "Text 3" is displayed
      }
    });

    if (_shouldRotate) {
      Future.delayed(Duration(seconds: 1), () {
        _rotateText();
      });
    }
  }

  void _startVibration1() {
    setState(() {
      vibrated == true ? isVibrating = true : isVibrating = false;
    });

    _timer = Timer(const Duration(seconds: 4), () {
      setState(() {
        isVibrating = false;
        _rotateText();
      });

      Vibration.cancel();

    });

    if (vibrated == true) {
      if (vibrated == true) {
        Vibration.vibrate(duration: 5000);
      } else {
        Vibration.cancel();
      }
    }
  }

  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  Timer? timerAudio;

  void playAudio() {
    setState(() {
      audioIcon == true ? audioPlayer = true : audioPlayer = false;
    });
    timerAudio = Timer(const Duration(seconds: 4), () {
      setState(() {
        audioPlayer = false;
        _rotateText();
      });
      assetsAudioPlayer.stop();
    });
    if (audioIcon == true) {
      if (audioIcon == true) {
        loadAudio();
        Timer(const Duration(milliseconds: 1500), () {
          if (audioPlayer == true) {
            loadAudio();
          }
        });
      } else {
        // Vibration.cancel();
        assetsAudioPlayer.stop();
      }
    }
  }

  void loopAudio() {
    assetsAudioPlayer.setLoopMode(LoopMode.single);
  }

  void stopAudio() {
    if (timerAudio!.isActive) {
      timerAudio!.cancel();
      setState(() {
        audioPlayer = false;
        // loopAudio();
        // assetsAudioPlayer.stop();
      });
      // Vibration.cancel();
      assetsAudioPlayer.stop();
      // Stop the audio when isVibrating becomes false
      // assetsAudioPlayer.stop();
    }
  }

  void loadAudio() {
    assetsAudioPlayer.open(
      Audio("assets/images/musics.mp3"),
    );
  }

  void _stopVibration() {
    if (_timer!.isActive) {
      _timer!.cancel();
      setState(() {
        isVibrating = false;
        // loopAudio();
        // assetsAudioPlayer.stop();
      });
      Vibration.cancel();

      // Stop the audio when isVibrating becomes false
      // assetsAudioPlayer.stop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller!.repeat(
        min: 0,
        max: 15,
        period: const Duration(seconds: 4),
      );
    });
  }
  Future<void> precacheImages() async {
    await Future.wait([
      precacheImage(AssetImage(backGroundImg), context),
      precacheImage(AssetImage(fingerprintOneImg), context),
      precacheImage(AssetImage(scanningImg), context),
      precacheImage(AssetImage( loadingGreenImg), context),
      precacheImage(AssetImage( loadingRedImg), context),
      precacheImage(AssetImage( vibrationImg), context),
      precacheImage(AssetImage( vibrateFalseImg), context)
    ]);

    setState(() {
      imagesLoaded = true;
    });
  }
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,

    ));
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
        backgroundColor: Colors.transparent,
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
                                      return HomeScreen();
                                    },
                                  ));
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: themeColor,
                                )),
                            Text(
                              translation(context).fingerPrintOneText,
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
                      child: isLongVisible
                          ? Lottie.asset(
                              heartBitGif,
                              height: 20.h,
                              width: 50.w,
                            )
                          : !Rotate
                              ? Text(
                                  isVisible
                                      ? translation(context)
                                          .waitFourSecondToScanText
                                      : translation(context)
                                          .pleasePressToScanningText,
                                  style: GoogleFonts.russoOne(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: themeColor),
                                )
                              : Text(
                                  _displayText,
                                  style: GoogleFonts.russoOne(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: themeColor),
                                )),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: isLongVisible
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
                        Container(
                          width: 2.w,
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: isLongVisible
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
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          print("------------------------------ONTAPCALL");
                          setState(() {
                            vibrated = !vibrated;
                            Vibration.cancel();
                          });
                        },
                        child: Container(
                          height: 7.h,
                          width: 15.w,
                          child: Center(
                            child: Image.asset(
                              vibrated != false
                                  ? vibrationImg
                                  : vibrateFalseImg,
                              height: 10.h,
                              width: 18.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("------------------------------ONTAPCALL");
                          setState(() {
                            audioIcon = !audioIcon;
                            // assetsAudioPlayer.dispose();
                          });
                        },
                        child: Container(
                          height: 7.h,
                          width: 15.w,
                          child: Center(
                            child: Image.asset(
                              audioIcon != false ? musicImg : musicFalseImg,
                              height: 10.h,
                              width: 18.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [

                    Container(
                      height: 5.w,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = true;
                          });
                          print('**************$isVisible');
                        },
                        onTapDown: (_) {
                          setState(() {
                            isLongVisible = true;
                          });
                          _startVibration1();
                          playAudio();
                        },
                        onTapUp: (_) {
                          setState(() {
                            // assetsAudioPlayer
                            //     .dispose();
                            isLongVisible = false;
                          });
                          _stopVibration();
                          stopAudio();
                        },
                        onTapCancel: () {
                          setState(() {
                            // assetsAudioPlayer
                            //     .dispose();
                            isLongVisible = false;
                          });
                          _stopVibration();
                          stopAudio();
                        },
                        child: GifImage(
                          height: 22.h,
                          controller: controller!,
                          image: const AssetImage(scanningImg),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowDialog(
            className: ResultScreen(
          voiceDetectScreen: 'FingerPlay1',
        ));
      },
    );
  }
}
