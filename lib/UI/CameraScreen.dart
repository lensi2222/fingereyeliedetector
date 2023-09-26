import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fingereyeliedetector/Resources/ImageResourceas.dart';
import 'package:fingereyeliedetector/Resources/colorResources.dart';
import 'package:fingereyeliedetector/UI/EyeDetectorScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../CustomWidget/PopupCustomWidget.dart';
import '../classes/language_constants.dart';
import 'ResultScreen.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  bool isScanning = false;

  final AssetsAudioPlayer _audioPlayer =
      AssetsAudioPlayer(); // Initialize AudioPlayer

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the AudioPlayer when done
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![1]);
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
    } on CameraException catch (e) {
      debugPrint('Error occurred while taking a picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("Camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return EyeDetectorScreen();
          },
        ));
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: scaffoldBakGroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              (_cameraController.value.isInitialized)
                  ? CameraPreview(_cameraController)
                  : Container(
                      child: const Center(child: CircularProgressIndicator())),
              Positioned(
                top: MediaQuery.of(context).size.width * 0.20,
                child: Row(
                  children: [
                    !isScanning
                        ? Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Image.asset(
                              eye1Img,
                              height: 17.h,
                              width: 40.w,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Lottie.asset(
                              eyeScanningGif,
                              height: 17.h,
                              width: 40.w,
                              // composition: eyeScanningGifComposition,
                              // Assign the composition to control the animation
                            ),
                          ),
                    SizedBox(
                      width: 5.w,
                    ),
                    !isScanning
                        ? Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Image.asset(
                              eye1Img,
                              height: 17.h,
                              width: 40.w,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Lottie.asset(
                              eyeScanningGif,
                              height: 17.h,
                              width: 40.w,
                              // composition: eyeScanningGifComposition,
                              // Assign the composition to control the animation
                            ),
                          ),
                  ],
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.35,
                bottom: MediaQuery.of(context).size.height * 0.20,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 6.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: scaffoldBakGroundColor,
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFC817C1),
                        Color(0xFF04D1F2),
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Play audio here when "Scan" is tapped
                      _playAudio();
                      setState(() {
                        isScanning = true; // Start scanning
                      });
                      Future.delayed(Duration(seconds: 4)).then((value) {
                        _showDialog(context);
                      });
                    },
                    child: Center(
                      child: Text(
                        isScanning
                            ? translation(context).scanningText
                            : translation(context).scanText,
                        style: GoogleFonts.russoOne(
                          color: themeColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      IconButton(
                        iconSize: 8.h,
                        icon: Icon(
                          _isRearCameraSelected
                              ? CupertinoIcons.switch_camera
                              : CupertinoIcons.switch_camera_solid,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() =>
                              _isRearCameraSelected = !_isRearCameraSelected);
                          initCamera(
                              widget.cameras![_isRearCameraSelected ? 0 : 1]);
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) async {
    setState(() {
      isScanning = false;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowDialog(
          className: ResultScreen(voiceDetectScreen: 'CameraScreen'),
        );
      },
    );
  }

  void _playAudio() {
    // Play audio here
    _audioPlayer.open(Audio("assets/images/musics.mp3"));
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      _audioPlayer.open(Audio("assets/images/musics.mp3"));
    });
  }
}
