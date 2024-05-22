import 'package:flutter/material.dart';
import 'responsive/another_body.dart';
import 'responsive/mobile_bady.dart';
import 'responsive/reponsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: const MyMobileBody(),
        tabletbody: const MyTabletBody(),
      ),
    );
  }
}
