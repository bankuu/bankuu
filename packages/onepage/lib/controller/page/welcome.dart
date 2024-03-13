import 'dart:async';

import 'package:get/get.dart';
import 'package:rive/rive.dart';

class WelcomeControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(WelcomeController._internal());
  }
}

class WelcomeController extends GetxController {
  late Timer? _timer;

  //region Welcome
  var textOpacity = 1.00.obs;
  var welcomeFooter = _SpeedController('runner', speedMultiplier: 1);
  var isEntering = false.obs;
  var isToMainMenu = false.obs;

  WelcomeController._internal();

  onEnter() {
    if (isEntering.isTrue) {
      return;
    }

    isEntering.value = true;

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (timer.tick % 3 == 0) {
        if (textOpacity.value == 0) {
          textOpacity.value = 1;
        } else {
          textOpacity.value = 0;
        }
      }

      if (welcomeFooter.speedMultiplier.value > 0.1 && isToMainMenu.isFalse) {
        welcomeFooter.speedMultiplier.value = welcomeFooter.speedMultiplier.value - (welcomeFooter.speedMultiplier.value / 3);
      } else {
        if (isToMainMenu.isFalse) {
          welcomeFooter.speedMultiplier.value = 0.01;
          isToMainMenu.value = true;
        }

        if (welcomeFooter.speedMultiplier.value < 8) {
          welcomeFooter.speedMultiplier.value = welcomeFooter.speedMultiplier.value + 0.25;
        } else {
          Get.offNamed("/portfolio");
        }
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
//endregion Welcome

}

class _SpeedController extends SimpleAnimation {
  final speedMultiplier = Rx<double>(1);

  _SpeedController(
    String animationName, {
    double mix = 1,
    double speedMultiplier = 1,
  }) : super(animationName, mix: mix) {
    this.speedMultiplier.value = speedMultiplier;
  }

  @override
  void apply(RuntimeArtboard artboard, double elapsedSeconds) {
    if (instance == null || !instance!.keepGoing) {
      isActive = false;
    }
    instance!
      ..animation.apply(instance!.time, coreContext: artboard, mix: mix)
      ..advance(elapsedSeconds * speedMultiplier.value);
  }
}
