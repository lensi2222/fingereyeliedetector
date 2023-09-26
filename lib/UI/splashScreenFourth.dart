import 'package:fingereyeliedetector/Resources/ImageResourceas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Resources/colorResources.dart';
import '../Resources/stringResources.dart';
import '../classes/language_constants.dart';
import 'SplashScreenFive.dart';
import 'SplashScreenThree.dart';

class SplashScreenFourth extends StatefulWidget {
  const SplashScreenFourth({Key? key}) : super(key: key);

  @override
  State<SplashScreenFourth> createState() => _SplashScreenFourthState();
}

class _SplashScreenFourthState extends State<SplashScreenFourth> {
  String? storedImages;
  bool imagesLoaded = false;

  Future<void> loadSelectedImagesIndex() async {
    final prefs = await SharedPreferences.getInstance();
    storedImages = prefs.getString('selectedImages') ??
        ""; // Use a default value if not found
    print("stor --> $storedImages");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadSelectedImagesIndex();
    // Delay image precaching to ensure the context is available
    Future.delayed(Duration.zero, () {
      precacheImages();
    });
  }

  Future<void> precacheImages() async {
    await Future.wait([
      precacheImage(AssetImage(backGroundImg), context),
      precacheImage(AssetImage(splashFourthImg), context)
    ]);


    setState(() {
      imagesLoaded = true;
    });
  }
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const SplashScreenThree();
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
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const SplashScreenThree();
                                    },
                                  ));
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
                        CircleAvatar(
                          backgroundImage:
                          storedImages != "" && storedImages != null
                              ? AssetImage(storedImages!)
                              : AssetImage(englishImg),
                          // Use the default image (e.g., englishImg) if no language is selected
                          radius: 20,
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Image.asset(
                            splashFourthImg,
                            height: 38.5.h,
                          )),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const SplashScreenFive();
                                  },
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            height: 6.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: scaffoldBakGroundColor,
                                    blurRadius: 5.0,
                                  ),
                                ],
                                // border:
                                //     Border.all(color: scaffoldBakGroundColor, width: 1.8),
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xFFC817C1),
                                    Color(0xFF04D1F2),
                                  ],
                                )
                            ),
                            child: Center(
                                child: Text(
                                  translation(context).nextText,
                                  style: GoogleFonts.russoOne(
                                      color: themeColor,
                                      fontSize: 12.sp),
                                )),
                          ),
                        )

                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
