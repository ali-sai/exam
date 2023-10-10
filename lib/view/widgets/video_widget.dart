import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../../helper/loading.dart';
import '../../view/video_player.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key, required this.url});
  final String url;
  @override
  State<VideoWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoWidget> {
  VideoPlayerController? _controller;
  bool _isLoading = true;
  bool _isMute = true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _controller!.initialize().then((value) {
      setState(() {
        _isLoading = false;
      });
      _controller?.play();
      _controller?.setVolume(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Loading();
    }
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder:(context) => MyVideoPlayer(controller: _controller!),));
      },
      child: GestureDetector(
        onTap: () {
          if (_isMute) {
            _controller?.setVolume(10);
            setState(() {
              _isMute = false;
            });
          }else{
                       _controller?.setVolume(0);
            setState(() {
              _isMute = true;
            });
          }
        },
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!))),
      ),
    );
  }
}