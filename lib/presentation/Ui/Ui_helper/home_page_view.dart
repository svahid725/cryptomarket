import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  final PageController controller;

  static List<String> images = [
    'images/a1.png',
    'images/a2.png',
    'images/a3.png',
    'images/a4.png',
  ];

  const HomePageView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      allowImplicitScrolling: true,
      controller: widget.controller,
      children: [
        myPages(HomePageView.images[0]),
        myPages(HomePageView.images[1]),
        myPages(HomePageView.images[2]),
        myPages(HomePageView.images[3]),
      ],
    );
  }

  Widget myPages(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image(
        image: AssetImage(image),
        fit: BoxFit.fill,

      ),
    );
  }
}
