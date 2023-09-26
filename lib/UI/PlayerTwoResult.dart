import 'dart:math';
import 'package:fingereyeliedetector/Resources/colorResources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Resources/ImageResourceas.dart';
import '../classes/language_constants.dart';
import 'FingerprintPlayerTwoScreen.dart';

class PlayerTwoResultScreen extends StatefulWidget {
  const PlayerTwoResultScreen({Key? key}) : super(key: key);

  @override
  State<PlayerTwoResultScreen> createState() => _PlayerTwoResultScreenState();
}

class _PlayerTwoResultScreenState extends State<PlayerTwoResultScreen> {
  List<String> stringList = [];
  List<String> stringTwoList = [];
  List<String> lieImagesList = [redContainerImg];
  List<String> lieImagesTwoList = [redContainerImg];
  List<String> trueImagesTwoList = [greenContainerImg];
  List<String> trueImagesList = [greenContainerImg];
  String randomString = '';
  String randomStringTwo = '';
  Image? randomLieImg;
  Image? randomLieTwoImg;
  Image? randomTrueImg;
  Image? randomTrueTwoImg;
  Color containerBorderColor = themeColor;
  Color textColor = themeColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access context-related data (e.g., translations) here.
    stringList = [
      translation(context).youLieText,
      translation(context).youTellTheTruthText,
    ];
    generateRandomString();
    stringTwoList = [
      translation(context).youLieText,
      translation(context).youTellTheTruthText,
    ];

    generateRandomStringTwo();
  }

  void generateRandomString() {
    Random random = Random();
    int randomIndex = random.nextInt(stringList.length);
    setState(() {
      randomString = stringList[randomIndex];
      if (randomString == translation(context).youLieText) {
        generateRandomLieImg();
      } else if (randomString == translation(context).youTellTheTruthText) {
        generateRandomTrueImg();
      }
    });
  }

  void generateRandomStringTwo() {
    Random random = Random();
    int randomIndex = random.nextInt(stringTwoList.length);
    setState(() {
      randomStringTwo = stringTwoList[randomIndex];
      if (randomStringTwo == translation(context).youLieText) {
        generateRandomLieImg();
      } else if (randomStringTwo == translation(context).youTellTheTruthText) {
        generateRandomTrueImg();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: scaffoldBakGroundColor,
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return FingerPrintPlayTwo();
            },
          ));
          return Future.value(false);
        },
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backGroundImg),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
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
                                    return FingerPrintPlayTwo();
                                  },
                                ));
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: themeColor,
                              ),
                            ),
                            Text(
                              translation(context).eyeDetectorText,
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        randomString == translation(context).youLieText
                            ? (randomLieImg?.image as AssetImage?)?.assetName ??
                                redContainerImg
                            : (randomTrueImg?.image as AssetImage?)
                                    ?.assetName ??
                                greenContainerImg,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                randomString,
                                style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: themeColor,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            translation(context).playerOneText,
                            style: GoogleFonts.russoOne(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: themeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 35.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        randomStringTwo == translation(context).youLieText
                            ? (randomLieTwoImg?.image as AssetImage?)
                                    ?.assetName ??
                                redContainerImg
                            : (randomTrueTwoImg?.image as AssetImage?)
                                    ?.assetName ??
                                greenContainerImg,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                randomStringTwo,
                                style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: themeColor,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            translation(context).playerTwoText,
                            style: GoogleFonts.russoOne(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: themeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 5.h,
                ),
                InkWell(
                  onTap: () async {

                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return FingerPrintPlayTwo();
                        },
                      ));

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
