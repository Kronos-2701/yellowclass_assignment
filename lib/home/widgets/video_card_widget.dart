import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../presentation/landing_1_screen.dart';

class VideoCardWidget extends StatefulWidget {
  const VideoCardWidget({
    Key? key,
    required this.url,
    required this.index,
    required this.imageUrl,
  }) : super(key: key);
  final String url;
  final int index;
  final String imageUrl;
  @override
  State<VideoCardWidget> createState() => _VideoCardWidgetState();
}

class _VideoCardWidgetState extends State<VideoCardWidget> {
  VideoPlayerController controller = VideoPlayerController.network("");
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == scrollIndex1) {
      controller = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          // controller.play();
        });
      chewieController = ChewieController(
        videoPlayerController: controller,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
      );
      chewieController.play();
    } else {
      controller.pause();
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: widget.index == scrollIndex1
          ? Chewie(controller: chewieController)
          : Image.network(widget.imageUrl),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
