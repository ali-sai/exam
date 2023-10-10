import 'dart:ui';

import 'package:exam/view/widgets/image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/add_post_controller.dart';
import '../../controller/controller.dart';
import '../../view/add_post.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({super.key});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Obx(
         
          () {
            AddPostController controller = Get.find<AddPostController>();
            return Stack(
              children: [
                // Background image
               if(controller.media.isNotEmpty) Center(
                  child: ImageContainer(file: controller.media[0], controller: controller, tap: false,),
                ),
                // Blurred overlay
                BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 6,
                      sigmaY: 6), // Adjust the sigma values for the blur effect
                  child: Container(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.grey,
                      value: controller.postingProgress.value,
                    )), // Make the container transparent
                  ),
                ),
              ],
            );
          }),
    );
  }
}
