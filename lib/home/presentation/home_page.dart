import 'dart:async';

import 'package:flutter/material.dart';

import 'package:yellowclass_assignment/home/data/json_data.dart';

import '../widgets/video_card_widget.dart';

var scrollIndex = 0;
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
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Yellow Class"),
        backgroundColor: Colors.red[800],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          off = scroller.offset;
          var cur = off / 255;

          Timer(const Duration(milliseconds: 600), () {
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
              crossAxisCount: 1, mainAxisExtent: 250, mainAxisSpacing: 5),
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
