import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task/features/onBoarding/models/page_model.dart';
import 'package:task/features/onBoarding/widgets/carousel_slider_widget.dart';
import 'package:task/features/onBoarding/widgets/skip_button.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';
import 'package:task/global/navigation_routes/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  List<PageModel> slides = [];
  int slideIndex = 0;
  CarouselSliderController carouselController = CarouselSliderController();

  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );

  @override
  void initState() {
    slides = getSlides();
    startAnimation(0);
    super.initState();
  }

  void startAnimation(index) async {
    animationController.reset();

    await animationController.forward();

    if (slideIndex == 2) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Routes.authScreen(context: context);
      });
    } else {
      carouselController.nextPage();
    }
    setState(() {});
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MQuery.getWidth(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MQuery.getheight(context, 40)),

            CarouselSliderWidget(
              onPageChange: (index) {
                setState(() {
                  slideIndex = index;
                });
                startAnimation(index);
              },
              carouselController: carouselController,
              slides: slides,
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    slides[slideIndex].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),

                  Container(
                    height: 8,

                    //color: Colors.pink,
                    child: Center(
                      child: AnimatedSmoothIndicator(
                        count: slides.length,
                        activeIndex: slideIndex,
                        effect: ScrollingDotsEffect(
                          activeDotColor: Colors.amber,
                          dotHeight: 8,
                          strokeWidth: 1,
                          dotWidth: 8,
                          dotColor: Colors.amber.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    slides[slideIndex].desc,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: MQuery.getheight(context, 35)),

            SkipButton(
              animationController: animationController,
              onPressSkip: () {
                if (slideIndex == 2) {
                  Routes.authScreen(context: context);
                } else {
                  carouselController.nextPage();
                  slideIndex++;
                  startAnimation(slideIndex);
                }
              },
            ),

            SizedBox(height: MQuery.getheight(context, 30)),
          ],
        ),
      ),
    );
  }
}
