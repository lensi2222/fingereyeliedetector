import 'package:fingereyeliedetector/UI/LanguageScreen.dart';
import 'package:fingereyeliedetector/UI/splashScreenFourth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Resources/ImageResourceas.dart';
import '../Resources/colorResources.dart';
import '../classes/language_constants.dart';

class SplashScreenFive extends StatefulWidget {
  const SplashScreenFive({Key? key}) : super(key: key);

  @override
  State<SplashScreenFive> createState() => _SplashScreenFiveState();
}

class _SplashScreenFiveState extends State<SplashScreenFive> {
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
      precacheImage(AssetImage(spFiveOneImg), context),
      precacheImage(AssetImage(spFiveTwoImg), context),
      precacheImage(AssetImage(spFiveThreeImg), context)
    ]);

    setState(() {
      imagesLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const SplashScreenFourth();
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
                children: [
                  /// App Bar
                  SizedBox(
                    height: 60,
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
                                      return const SplashScreenFourth();
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

                  /// Player Container
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Container(
                          height: 14.8.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(splashFivesImg),
                                  fit: BoxFit.fill)),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  shareAppImg,
                                  height: 3.h,
                                ),
                                Container(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Text(
                                    translation(context).shareAppText,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.russoOne(
                                        fontSize: 15.sp, color: themeColor),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Container(
                          height: 14.8.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(splashFivesImg),
                                  fit: BoxFit.fill)),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  privacyPolicyImg,
                                  height: 3.h,
                                ),
                                Container(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Text(
                                    translation(context).privacyPolicyText,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.russoOne(
                                        fontSize: 15.sp, color: themeColor),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Container(
                          height: 14.8.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(splashFivesImg),
                                  fit: BoxFit.fill)),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  rateAppIconImg,
                                  height: 3.h,
                                ),
                                Container(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    translation(context).rateAppText,
                                    style: GoogleFonts.russoOne(
                                        fontSize: 12.sp, color: themeColor),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),

                  /// Next Screen
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return LanguageScreen();
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
                                )),
                            child: Center(
                                child: Text(
                              translation(context).nextText,
                              style: GoogleFonts.russoOne(
                                  color: themeColor, fontSize: 12.sp),
                            )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
