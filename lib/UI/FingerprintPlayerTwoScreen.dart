import 'dart:async';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fingereyeliedetector/Resources/colorResources.dart';
import 'package:fingereyeliedetector/UI/PlayerTwoResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:vibration/vibration.dart';
import '../CustomWidget/PopupCustomWidget.dart';
import '../CustomWidget/loadingContainer.dart';
import '../Resources/ImageResourceas.dart';
import '../classes/language_constants.dart';
import 'HomeScreen.dart';

class FingerPrintPlayTwo extends StatefulWidget {
  const FingerPrintPlayTwo({Key? key}) : super(key: key);

  @override
  State<FingerPrintPlayTwo> createState() => _FingerPrintPlayTwoState();
}

class _FingerPrintPlayTwoState extends State<FingerPrintPlayTwo>
    with TickerProviderStateMixin {
  bool isButtonTapped = false;
  bool button1Pressed = false;
  bool button2Pressed = false;
  bool vibrated = true;
  int _currentTextIndex = 0;
  bool _shouldRotate = true;
  bool isLongVisible = false;
  String _displayText = '..';
  bool Rotate = false;
  Timer? _timer;
  bool isVisible = false;
  bool audioIcon = true;
  bool audioPlayer = true;
  FlutterGifController? controller;
  List<String> textOptions = [];

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
    mainContainerText = [
      translation(context).random1Text,
      translation(context).random2Text,
      translation(context).random3Text,
      translation(context).random4Text,
      translation(context).random5Text,
      translation(context).random6Text,
      translation(context).random7Text,
      translation(context).random8Text,
      translation(context).random9Text,
      translation(context).random10Text,
      translation(context).random11Text,
      translation(context).random12Text,
      translation(context).random13Text,
      translation(context).random14Text,
      translation(context).random15Text,
      translation(context).random16Text,
      translation(context).random17Text,
      translation(context).random18Text,
      translation(context).random19Text,
      translation(context).random20Text,
      translation(context).random21Text,
      translation(context).random22Text,
      translation(context).random23Text,
    ];
    // generateRandomString();
  }

  List<String> mainContainerText = [];

  mainContainerRandom() {
    Random random = Random();
    int randomIndex = random.nextInt(mainContainerText.length);
    String randomString = mainContainerText[randomIndex];
    print("Random String: $randomString");
    return randomString;
  }

  void checkBothButtonsPressed() {
    if (button1Pressed && button2Pressed) {
      print('Both buttons are pressed at the same time!');
      _startVibration1();
      playAudio();
    }
  }

  void _startVibration1() {
    setState(() {
      vibrated == true ? isVibrating = true : isVibrating = false;
    });

    _timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        isVisible = true;

        isVibrating = false;

        _rotateText();
      });

      Vibration.cancel();

    });
    if (vibrated == true) {
      vibrated == true ? Vibration.vibrate(duration: 5000) : Vibration.cancel();
      // if (!assetsAudioPlayer.isPlaying.value) {
      //   audio == true ? loadAudio() : assetsAudioPlayer.dispose();
      //   // playAudio();
      // }
      // audio == true ? loopAudio() : assetsAudioPlayer.dispose();
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
      //
      // Vibration.cancel();
      assetsAudioPlayer.stop();

      // if (!isVibrating) {
      //   assetsAudioPlayer.stop();
      // }
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

  void loadAudio() {
    assetsAudioPlayer.open(
      Audio("assets/images/musics.mp3"),
    );
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

  void loopAudio() {
    assetsAudioPlayer.setLoopMode(LoopMode.single);
  }

  void _stopVibration() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      setState(() {
        isVibrating = false;
        assetsAudioPlayer.stop();
      });
      Vibration.cancel();
      assetsAudioPlayer.stop();
    }
  }

  // void playAudio() {
  //   assetsAudioPlayer.play();
  // }

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

  @override
  void dispose() {
    // Cancel the delayed execution when the widget is disposed
    // assetsAudioPlayer.dispose();
    _shouldRotate = false;
    controller!.dispose();
    super.dispose();
  }

  void handleTap() {
    print('GestureDetector tapped');
    if (!isButtonTapped) {
      setState(() {
        isButtonTapped = true;
      });
    }
    // Call the random text function when the button is tapped
    String randomText = mainContainerRandom();
    setState(() {
      isVisible = true;
      _displayText = randomText;
    });
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
                image: AssetImage(backGroundImg),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
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
                              ),
                            ),
                            Text(
                              translation(context).fingerPrintTwoText,
                              style: GoogleFonts.russoOne(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: themeColor,
                              ),
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
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: isLongVisible
                        ? Lottie.asset(
                            heartBitGif,
                            height: 20.h,
                            width: 50.w,
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: Center(
                              child: Text(
                                isVisible
                                    ? _displayText
                                    : (isButtonTapped
                                        ? mainContainerRandom()
                                        : ""),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                  color: themeColor,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Container(
                  height: 1.h,
                ),
                Visibility(
                  visible: isButtonTapped,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              button1Pressed = true;
                              isLongVisible = true;
                              checkBothButtonsPressed();
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              button1Pressed = false;
                              isLongVisible = false;
                            });
                            _stopVibration();
                            stopAudio();
                          },
                          onTapUp: (_) {
                            setState(() {
                              button1Pressed = false;
                              isLongVisible = false;
                              _stopVibration();
                              stopAudio();
                            });
                          },
                          child: Container(
                            height: 17.h,
                            padding: const EdgeInsets.all(8.0),
                            child: GifImage(
                              controller: controller!,
                              image: AssetImage(
                                scanningImg,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: button1Pressed && button2Pressed == true
                              ? Lottie.asset(
                                  fingerTwoGif,
                                  height: 12.h,
                                  width: 100.w,
                                )
                              : Text(
                                  isButtonTapped
                                      ? translation(context)
                                          .secondScreenButtonText
                                      : "",
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.russoOne(
                                    fontSize: 10.sp,
                                    color: themeColor,
                                  ),
                                ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              button2Pressed = true;
                              isLongVisible = true;
                              checkBothButtonsPressed();
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              button2Pressed = false;
                              isLongVisible = false;
                            });
                            _stopVibration();
                            // stopAudio();
                          },
                          onTapUp: (_) {
                            setState(() {
                              button2Pressed = false;
                              isLongVisible = false;
                              _stopVibration();
                              // stopAudio();
                            });
                          },
                          child: Container(
                            height: 17.h,
                            padding: const EdgeInsets.all(8.0),
                            child: GifImage(
                              controller: controller!,
                              image: AssetImage(
                                scanningImg,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.h,
                ),
                Visibility(
                    visible: isButtonTapped,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Image.asset(
                              userOneImg,
                              height: 7.h,
                            ),
                          ),
                          Container(
                            child: Image.asset(
                              userTwoImg,
                              height: 7.h,
                            ),
                          )
                        ],
                      ),
                    )),
                Visibility(
                    visible: isButtonTapped,
                    child:  Padding(
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
                    ),),
                Visibility(
                  visible: isButtonTapped,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                ),
                Spacer(),
                Visibility(
                  visible: !isButtonTapped,
                  child: GestureDetector(
                    onTap: handleTap,
                    child: Container(
                      height: 10.h,
                      width: 60.w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(eyeStartFrameImg),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          translation(context).letsStartText,
                          style: GoogleFonts.russoOne(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: themeColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 5.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isVibrating = false;
  DateTime? lastTapTime;

  void startVibration() {
    setState(() {
      isVibrating = true;
    });
    Vibration.vibrate(duration: 100, repeat: 1);
  }

  void stopVibration() {
    setState(() {
      isVibrating = false;
    });
    Vibration.cancel();
  }

  void handleWidgetTap(int widgetNumber) {
    final currentTime = DateTime.now();

    if (lastTapTime != null &&
        currentTime.difference(lastTapTime!).inSeconds <= 5) {
      startVibration();
    } else {
      lastTapTime = currentTime;
      stopVibration();
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowDialog(className: const PlayerTwoResultScreen());
      },
    );
  }
}
