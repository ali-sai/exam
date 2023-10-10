import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/add_post_controller.dart';

import '../controller/controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AddPostController());
    Get.put(Controller());
  }
}
