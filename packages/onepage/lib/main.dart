import 'package:bankuu_info_site/controller/page/welcome.dart';
import 'package:bankuu_info_site/utility.dart';
import 'package:bankuu_info_site/view/page/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


void main() {
  runApp(
    GetCupertinoApp(
      title: "BANKUU - bankuu.info",
      initialRoute: "/",
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorSet.background.color,
        textTheme: const CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: "IanCPU"),
        ),
      ),
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 800),
      getPages: [
        GetPage(
          name: "/",
          page: () => const WelcomePage(),
          binding: WelcomeControllerBinding(),
        ),
      ],
    ),
  );
}
