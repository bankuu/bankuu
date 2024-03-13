import 'package:bankuu_info_site/controller/page/welcome.dart';
import 'package:bankuu_info_site/utility.dart';
import 'package:bankuu_info_site/view/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(children: [
        _buildRawWelcomePage(context),
        ShareView.buildButtonBar(context),
      ]),
    );
  }

  Widget _buildRawWelcomePage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onEnter();
      },
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 80),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => LinearGradient(colors: [
                    ColorSet.textBegin.color,
                    ColorSet.textEnd.color,
                  ]).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOutCubic,
                    builder: (BuildContext context, double size, Widget? child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("BANKUU", style: TextStyle(fontSize: size * 450, height: 0.6)),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Obx(() => AnimatedContainer(
                height: controller.isToMainMenu.isFalse ? Get.height : 0,
                curve: Curves.easeInOut,
                duration: const Duration(seconds: 8),
                child: rive.RiveAnimation.asset(
                  'asset/rive/welcome-footer.riv',
                  fit: BoxFit.fill,
                  controllers: [
                    controller.welcomeFooter,
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
