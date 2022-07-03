import 'dart:async';

import 'package:flutter/material.dart';

import 'package:yellowclass_assignment/home/data/json_data.dart';

import '../widgets/video_card_widget.dart';

var scrollIndex1 = 0;
var off1 = 0.0;

class Landing1 extends StatefulWidget {
  const Landing1({Key? key}) : super(key: key);

  @override
  State<Landing1> createState() => _Landing1State();
}

class _Landing1State extends State<Landing1> {
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
          off1 = scroller.offset;
          var cur = off1 / 270;

          Timer(const Duration(milliseconds: 600), () {
            if (scrollIndex1 != cur.ceil()) {
              if (mounted) {
                setState(() {
                  scrollIndex1 = cur.ceil();
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
