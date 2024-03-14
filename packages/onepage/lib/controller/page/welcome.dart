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
