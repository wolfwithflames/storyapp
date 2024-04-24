import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<Widget> items;
  final double height;
  final double viewportFraction;
  final Duration autoPlayInterval;
  final bool autoPlay;
  final bool enableInfiniteScroll;
  final CarouselController? carouselController;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  const CarouselSliderWidget(
    this.items, {
    Key? key,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.height = 0.15,
    this.autoPlay = false,
    this.enableInfiniteScroll = false,
    this.carouselController,
    this.viewportFraction = 1 / 6,
    this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * height,
        viewportFraction: viewportFraction,
        initialPage: 0,
        enableInfiniteScroll: enableInfiniteScroll,
        reverse: false,
        autoPlay: autoPlay,
        autoPlayInterval: autoPlayInterval,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
        disableCenter: false,
        pageSnapping: true,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        onPageChanged: onPageChanged,
        padEnds: false,
      ),
      carouselController: carouselController,
    );
  }
}
