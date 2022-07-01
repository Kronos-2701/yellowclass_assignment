import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:yellowclass_assignment/constant_data/json_data.dart';

var scrollIndex = 0;
var off = 0.0;
initControler(String url, VideoPlayerController controller) {
  controller = VideoPlayerController.network(url)
    ..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    });
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late VideoPlayerController _controller;
  ScrollController scroller = ScrollController();
  @override
  void initState() {
    scroller.addListener(() {
      if (scroller.offset == scroller.position.maxScrollExtent) {}
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          off = scroller.offset;
          var cur = off / 200;
          print(cur);
          print("absolute" + cur.ceil().toString());
          print(scroller.position.atEdge.toString());

          print("offset" + scroller.offset.toString());

          setState(() {
            scrollIndex = cur.ceil();
          });

          return false;
        },
        child: GridView.builder(
          controller: scroller,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisExtent: 200,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            // return Container(
            //     height: 200,
            //     padding: const EdgeInsets.all(10),
            //     child: Container(
            //         width: double.infinity,
            //         color: index == scrollIndex ? Colors.green : Colors.red));
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
  late final VideoPlayerController controller;
  // @override
  // void initState() {
  //   controller = VideoPlayerController.network(widget.url)
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {});
  //     });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.index == scrollIndex) {
      initControler(widget.url, controller);
    }
    var currentIndex = (off / 200);
    return Container(
      padding: const EdgeInsets.all(10),
      child: widget.index == currentIndex
          ? VideoPlayer(controller)
          : Image.network(widget.imageUrl),
    );
  }
}
