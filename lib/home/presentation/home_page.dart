import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:yellowclass_assignment/home/data/json_data.dart';

import '../widgets/video_card_widget.dart';

var scrollIndex = -1;
var off = 0.0;

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

          Timer(const Duration(milliseconds: 700), () {
            if (scrollIndex != cur.ceil()) {
              if (mounted) {
                setState(() {
                  scrollIndex = cur.ceil();
                });
              }
            }
          });

          return true;
        },
        child: GridView.builder(
          controller: scroller,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisExtent: 280, mainAxisSpacing: 20),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return VideoCardWidget(
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
