import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yellowclass_assignment/home/presentation/landing_1_screen.dart';
import 'package:yellowclass_assignment/home/presentation/landing_2_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yellow Class'),
        backgroundColor: Colors.red[800],
        bottom: TabBar(
          controller: controller,
          dragStartBehavior: DragStartBehavior.down,
          tabs: [
            Tab(
              icon: Icon(Icons.beach_access_sharp),
            ),
            Tab(
              icon: Icon(Icons.brightness_5_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [Landing1(), Landing2()],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
