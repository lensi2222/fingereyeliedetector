import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Resources/ImageResourceas.dart';
import '../Resources/colorResources.dart';
import '../classes/language_constants.dart';
import 'SplashScreenTwo.dart';

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({Key? key}) : super(key: key);

  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {
  String? storedImages;
  bool imagesLoaded = false; // Add a flag to track image loading

  Future<void> loadSelectedImagesIndex() async {
    final prefs = await SharedPreferences.getInstance();
    storedImages = prefs.getString('selectedImages') ?? "";
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
      precacheImage(AssetImage(firstHandImg), context),
      // Add more images to preload here if needed
    ]);

    // Set the flag to indicate that images are loaded
    setState(() {
      imagesLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backGroundImg),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 6.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: themeColor,
                          ),
                        ),
                        Text(
                          translation(context).lieDetectorText,
                          style: GoogleFonts.russoOne(
                            fontSize: 14.sp,
                            color: themeColor,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage:
                      imagesLoaded // Check if images are loaded
                          ? AssetImage(storedImages ?? englishImg)
                          : AssetImage(englishImg),
                      radius: 20,
                    )
                  ],
                ),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      firstHandImg,
                      height: 34.h,
                      width: 72.w,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Center(
                      child: Text(
                        translation(context).fingerPrintScanAndEyeText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.russoOne(
                          fontSize: 15.sp,
                          color: themeColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 2.0.h,
                    ),
                    child: Center(
                      child: Text(
                        translation(context).youAreLieRightText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.russoOne(
                          fontSize: 12.sp,
                          color: themeColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const SplashScreenTwo();
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
                        child: Center(
                          child: Text(
                            translation(context).nextText,
                            style: GoogleFonts.russoOne(
                              color: themeColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
