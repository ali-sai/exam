import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/widgets/image_container.dart';
import '../view/widgets/progress_widget.dart';

import '../controller/add_post_controller.dart';

class SharePost extends StatefulWidget {
  const SharePost({super.key});

  @override
  State<SharePost> createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isOpen = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  _toggleAnimation() {
    setState(() {
      if (!_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<AddPostController>();

      if (controller.imagesList.isEmpty) {
        return ProgressWidget();
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Add Post'),
          actions: [
              TextButton(
                  onPressed: () {
                    controller.uploadImages(_textEditingController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: _isOpen
                    ? Container(
                        key: ValueKey<int>(1),
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: ImageContainer(
                          file: controller.media[0],
                          controller: controller,
                          tap: false,
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          key: ValueKey<int>(2),
                          children: controller.media.map((element) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: ImageContainer(
                                file: element,
                                controller: controller,
                                tap: false,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
              ),
              if (controller.media.length > 1)
                IconButton(
                  onPressed: _toggleAnimation,
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_arrow,
                    progress: _controller,
                  ),
                ),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(hintText: 'Content'),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
