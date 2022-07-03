import 'dart:async';

import 'package:flutter/material.dart';

import 'package:yellowclass_assignment/home/data/json_data.dart';
import 'package:yellowclass_assignment/home/widgets/video_card_widget_2.dart';

var scrollIndex2 = 0;
var off = 0.0;

class Landing2 extends StatefulWidget {
  const Landing2({Key? key}) : super(key: key);

  @override
  State<Landing2> createState() => _Landing2State();
}

class _Landing2State extends State<Landing2> {
  ScrollController scroller = ScrollController();
  @override
  void initState() {
    super.initState();
    scroller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          off = scroller.offset;
          var cur = off / 270;

          Timer(const Duration(milliseconds: 600), () {
            if (scrollIndex2 != cur.ceil()) {
              if (mounted) {
                setState(() {
                  scrollIndex2 = cur.ceil();
                });
              }
            }
          });

          return true;
        },
        child: GridView.builder(
          controller: scroller,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisExtent: 250, mainAxisSpacing: 20),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return VideoCardWidget2(
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
