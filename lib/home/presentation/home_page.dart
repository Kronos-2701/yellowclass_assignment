import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:yellowclass_assignment/constant_data/json_data.dart';

var scrollIndex = 0;
var off = 0.0;
initControler(String url, VideoPlayerController controller) {
  controller = VideoPlayerController.network(url)
    ..initialize().then(
      (_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      },
    );
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ScrollController scroller = ScrollController();
  @override
  void initState() {
    super.initState();
    scroller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          off = scroller.offset;
          var cur = off / 300;
          // print(cur.ceil());
          // print("absolute" + cur.ceil().toString());
          // print(scroller.position.atEdge.toString());

          // print("offset" + scroller.offset.toString());
          if (scrollIndex != cur.ceil()) {
            // print("chal gya");

            if (mounted) {
              setState(() {
                scrollIndex = cur.ceil();
              });
            }
          }

          return true;
        },
        child: GridView.builder(
          controller: scroller,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisExtent: 250, mainAxisSpacing: 50),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return VideoCard(
              url: data[index]['videoUrl'],
              imageUrl: data[index]['coverPicture'],
              index: index,
            );
          },
        ),
      ),
    );
  }
}

class VideoCard extends StatefulWidget {
  const VideoCard({
    Key? key,
    required this.url,
    required this.index,
    required this.imageUrl,
  }) : super(key: key);
  final String url;
  final int index;
  final String imageUrl;
  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController controller = VideoPlayerController.network("");
  late ChewieController chewieController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == scrollIndex) {
      controller = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          controller.play();
        });
    } else {
      controller.pause();
    }

    return Container(
        padding: const EdgeInsets.all(10),
        child: widget.index == scrollIndex
            ? VideoPlayer(controller)
            : Image.network(widget.imageUrl)

        // ? VideoPlayer(controller)
        // : Image.network(widget.imageUrl),
        );
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }
}
