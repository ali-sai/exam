import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../controller/add_post_controller.dart';
import '../view/share_post.dart';
import '../view/widgets/feed_widget.dart';
import '../view/widgets/image_container.dart';
import '../view/widgets/progress_widget.dart';

import '../controller/controller.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
     Obx(() {
        final controller = Get.find<AddPostController>();
        if (controller.imagesList.isEmpty) {
          return ProgressWidget();
        } 
          return 
    Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => SharePost(),));
          }, child: const Text('Next'))
        ],
      ),
      body:Column(
            children: [
              Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: controller.media.isNotEmpty?ImageContainer(file: controller.media[0]!, controller: controller, tap: false,):null),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: controller.imagesList.length,
                  itemBuilder: (context, index) {
                    return ImageContainer(file: controller.imagesList[index]!, controller: controller,);
                  },
                ),
              ),
            ],
          )
        
      
    );});
  }
}
