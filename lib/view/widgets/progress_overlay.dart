import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';

class ProgressOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(color: MediaQuery.of(context).platformBrightness == Brightness.light? Colors.white: Colors.black),
            child: Column(
              children: [
                Text(
                  'Posting',
                  style: TextStyle(
                    color:MediaQuery.of(context).platformBrightness == Brightness.light? Colors.black: Colors.white,
                    fontSize: 30,
                    decoration: TextDecoration.combine([]),
                  ),
                ),
                GetBuilder<Controller>(
                  init: Controller(),
                  builder: (controller) {
                    return LinearProgressIndicator(
                      color: MediaQuery.of(context).platformBrightness == Brightness.light?Colors.black: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      value: controller.addPostController.postingProgress.value,
                    );
                  }
                )
              ],
            )), // Progress bar widget.
      ),
    );
  }
}
