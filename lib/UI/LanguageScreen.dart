import 'package:fingereyeliedetector/Resources/ImageResourceas.dart';
import 'package:fingereyeliedetector/Resources/colorResources.dart';
import 'package:fingereyeliedetector/UI/SplashScreenFive.dart';
import 'package:fingereyeliedetector/classes/language.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Resources/ListResources.dart';
import '../classes/language_constants.dart';
import '../main.dart';
import 'HomeScreen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedLanguageIndex = 0;
  int? storedIndex;
  String? storedImages;
  int indexTemp = 0;

  @override
  void initState() {
    super.initState();
    firstTap = false;
    // Load the selectedLanguageIndex from shared preferences when the widget initializes
    loadSelectedLanguageIndex();
    loadSelectedImagesIndex();
  }

  Future<void> loadSelectedLanguageIndex() async {
    final prefs = await SharedPreferences.getInstance();
    storedIndex = prefs.getInt('selectedLanguageIndex') ??
        0; // Use a default value if not found
    print("stor --> $storedIndex");
    setState(() {});
  }

  Future<void> loadSelectedImagesIndex() async {
    final prefs = await SharedPreferences.getInstance();
    storedImages = prefs.getString('selectedImages') ??
        ""; // Use a default value if not found
    print("stor --> $storedImages");
    setState(() {});
  }

  Future<void> saveSelectedLanguageIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedLanguageIndex', index);
  }

  Future<void> saveSelectedImagesIndex(String selectedImages) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedImages', selectedImages);
  }

  bool firstTap = false;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const SplashScreenFive();
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
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const SplashScreenFive();
                                    },
                                  ));
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: themeColor,
                                )),
                            Text(
                              translation(context).languageText,
                              style: GoogleFonts.russoOne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: themeColor),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundImage: storedImages != "" &&
                              storedImages != null
                              ? firstTap != true ? AssetImage(storedImages!)
                              : selectedLanguageIndex == indexTemp
                              ? AssetImage(languageList[selectedLanguageIndex]
                              .images!)
                              : AssetImage(englishImg) : AssetImage(englishImg),
                          radius: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) {
                            print('--->$index');
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Divider(),
                            );
                          },
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: Language
                              .languageList()
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 1.h),
                              child: Column(
                                children: [
                                  Container(
                                    child: Center(
                                      child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            firstTap = true;
                                            indexTemp = index;
                                            selectedLanguageIndex = index;
                                            print(
                                                "select jjj - $selectedLanguageIndex");
                                            print("select jjj - $index");
                                          });
                                          saveSelectedImagesIndex(
                                              languageList[index].images!);
                                          saveSelectedLanguageIndex(
                                              selectedLanguageIndex);

                                          Language selectedLanguage =
                                          Language.languageList()[index];
                                          Locale _locale = await setLocale(
                                              selectedLanguage.languageCode);
                                          MyApp.setLocale(context, _locale);
                                        },
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(50.0),
                                              child: Image.asset(
                                                languageList[index].images!,
                                                height: 3.h,
                                                width: 7.w,
                                              ),
                                              // child: Text(
                                              //   Language.languageList()[index].flag,
                                              //   style: const TextStyle(fontSize: 30),
                                              // ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              Language.languageList()[index].name,
                                              style: GoogleFonts.russoOne(
                                                fontSize: 13.sp,
                                                color: themeColor,
                                              ),
                                            ),
                                            Spacer(),
                                            storedIndex != null
                                                ? firstTap != true
                                                ? storedIndex == index
                                                ? Image.asset(
                                              selectLanImg,
                                              height: 3.h,
                                              width: 7.w,
                                            )
                                                : Container()
                                                : selectedLanguageIndex ==
                                                index
                                                ? Image.asset(
                                              selectLanImg,
                                              height: 3.h,
                                              width: 7.w,
                                            )
                                                : Container()
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Divider(),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(
                                        selectedLanguageImage: storedIndex != null
                                            ? languageList[storedIndex!].images!
                                            : englishImg,
                                      )),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.h),
                            child: Container(
                              width: double.infinity,
                              height: 5.h,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
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
                                  translation(context).startAppText,
                                  style: GoogleFonts.russoOne(
                                    fontSize: 13.sp,
                                    color: themeColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 10.h,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Language? selectedLanguage;
}
