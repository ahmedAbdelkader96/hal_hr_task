import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task/features/onBoarding/models/page_model.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
    required this.onPageChange,
    required this.carouselController,
    required this.slides,
  });

  final Function(int) onPageChange;
  final CarouselSliderController carouselController;
  final List<PageModel> slides;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      items: List.generate(
        slides.length,
        (index) =>
            LottieBuilder.asset(slides[index].lottiePath, fit: BoxFit.contain),
      ),
      options: CarouselOptions(
        height: MQuery.getheight(
          context,
          MediaQuery.of(context).orientation == Orientation.landscape
              ? 350
              : 400,
        ),
        disableCenter: true,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        autoPlayCurve: Curves.linear,
        enlargeCenterPage: true,

        onPageChanged: (index, _) {
          onPageChange(index);
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
