import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../Resources/ImageResourceas.dart';
import '../Resources/colorResources.dart';
import '../Resources/stringResources.dart';
import '../classes/language_constants.dart';
import '../main.dart';
import 'SplashScreenOne.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const SplashScreenOne();
          },
        ));
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const SplashScreenOne();
          },
        ));
      });
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const SplashScreenOne();
          },
        ));
      });
    } else if (connectivityResult == ConnectivityResult.vpn) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const SplashScreenOne();
          },
        ));
      });
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
    } else if (connectivityResult == ConnectivityResult.other) {
    } else if (connectivityResult == ConnectivityResult.none) {
      noInternetDialog();
    }
  }

  noInternetDialog() {
    showDialog(
      context: MyApp.navigatorKey.currentContext!,
      // barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(2.w),
                child: Lottie.asset(noInternetImg, height: 20.h, width: 50.w),
              ),
              Padding(
                padding: EdgeInsets.all(2.w),
                child: Text(
                  translation(context). noInternetText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.russoOne(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: Colors.black),
                ),
              ),
              InkWell(
                onTap: () {
                  exit(0);
                },
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Container(
                    height: 5.h,
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(15.w)),
                    child: Center(
                      child: Text(
                        translation(context). closeText,
                        style: GoogleFonts.russoOne(
                            fontWeight: FontWeight.w600,
                            color: scaffoldBakGroundColor,
                            fontSize: 10.sp),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    // precacheImages();
    checkConnection();
    super.initState();
  }
  bool imagesLoaded = false;
  // Future<void> precacheImages() async {
  //   await Future.wait([
  //     precacheImage(AssetImage(splashScreenImg), context),
  //     precacheImage(AssetImage(splashScreenGif), context),
  //   ]);
  //
  //   setState(() {
  //     imagesLoaded = true;
  //   });
  // }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: scaffoldBakGroundColor,
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Center(
              child: Image.asset(
            splashScreenImg,
            height: 40.h,
            width: 90.w,
          )),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                translation(context).lieDetectorTestScan,
                style: GoogleFonts.rubik(
                    color: themeColor.withOpacity(0.5),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child:
                    Lottie.asset(splashScreenGif, height: 20.h, width: 50.w)),
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
        Column(
          children: [
            Text(
              translation(context).splashScreenText,
              style: GoogleFonts.russoOne(
                  color: themeColor.withOpacity(0.5),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
      ]),
    );
  }
}
