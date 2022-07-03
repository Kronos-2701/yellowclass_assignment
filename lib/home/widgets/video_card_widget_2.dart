import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../presentation/landing_2_screen.dart';

class VideoCardWidget2 extends StatefulWidget {
  const VideoCardWidget2({
    Key? key,
    required this.url,
    required this.index,
    required this.imageUrl,
  }) : super(key: key);
  final String url;
  final int index;
  final String imageUrl;
  @override
  State<VideoCardWidget2> createState() => _VideoCardWidget2State();
}

class _VideoCardWidget2State extends State<VideoCardWidget2> {
  VideoPlayerController controller = VideoPlayerController.network("");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == scrollIndex2) {
      controller = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          controller.play();
        });
    } else {
      controller.pause();
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: widget.index == scrollIndex2
          ? VideoPlayer(controller)
          : Image.network(widget.imageUrl),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
