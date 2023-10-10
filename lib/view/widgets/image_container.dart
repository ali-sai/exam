import 'dart:io';

import 'package:flutter/material.dart';
import '../../controller/add_post_controller.dart';
import '../../view/widgets/thumbnail_widget.dart';

class ImageContainer extends StatefulWidget {
   ImageContainer({super.key, required this.file, required this.controller,  this.tap = true});
  final File file;
  final AddPostController controller;
   bool tap;
  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tap?() {
        setState(() {
          
        widget.controller.addMedia(widget.file);
        });
      }:null,
      child: Container(
        decoration: BoxDecoration(
          border:widget.controller.checkIsAdded(widget.file)? Border.all(color: Colors.white):null,
          borderRadius: BorderRadius.circular(12)
        ),
        child:
            widget.file.path.contains('png') || widget.file.path.contains('jpg')
                ? Image.file(widget.file)
                : ThumbnailWidget(file: widget.file),
      ),
    );
  }
}
