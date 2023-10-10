import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../helper/thumbnail_generate.dart';

class ThumbnailWidget extends StatefulWidget {
  const ThumbnailWidget({super.key, required this.file});
  final File file;
  @override
  State<ThumbnailWidget> createState() => _ThumbnailWidgetState();
}

class _ThumbnailWidgetState extends State<ThumbnailWidget> {
  Uint8List? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateThumbnail(widget.file).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Stack(
      children: [
        Center(child: Image.memory(data!)),
        Positioned(
            right: 10, top: 10, child: Icon(Icons.video_collection_outlined))
      ],
    );
  }
}
