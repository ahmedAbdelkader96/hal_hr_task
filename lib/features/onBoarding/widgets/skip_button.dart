import 'package:flutter/material.dart';
import 'package:task/features/onBoarding/widgets/stop_watch_custom_painter.dart';

class SkipButton extends StatefulWidget {
  const SkipButton({
    super.key,
    required this.animationController,
    required this.onPressSkip,
    required this.index,
  });

  final AnimationController animationController;
  final Function() onPressSkip;
  final int index;

  @override
  State<SkipButton> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  late AnimationController animationController1 = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );
  late AnimationController animationController2 = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );
  late AnimationController animationController3 = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    animation1 = Tween<double>(begin: 0, end: 0.33).animate(
      CurvedAnimation(parent: animationController1, curve: Curves.easeInOut),
    );

    animation2 = Tween<double>(begin: 0, end: 0.33).animate(
      CurvedAnimation(parent: animationController2, curve: Curves.easeInOut),
    );

    animation3 = Tween<double>(begin: 0, end: 0.33).animate(
      CurvedAnimation(parent: animationController3, curve: Curves.easeInOut),
    );

    animationController1.forward();
  }

  Future<void> _onPressed() async {
    if (widget.index == 0) {
      animationController2.forward();
    } else if (widget.index == 1) {
      animationController3.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    animationController1.dispose();
    animationController2.dispose();
    animationController3.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        final double h1 =
            MediaQuery.of(context).orientation == Orientation.landscape
                ? 33
                : 40.0;
        final double h2 =
            MediaQuery.of(context).orientation == Orientation.landscape
                ? 50
                : 60.0;
        return Stack(
          alignment: Alignment.center,

          children: [
            CustomPaint(
              painter: StopWatchCustomPainter(
                progressAnimation:
                    1 -
                    (animation1.value + animation2.value + animation3.value),
              ),
              size: Size(h1, h1),
            ),

            InkWell(
              customBorder: CircleBorder(),
              onTap: () async {
                await _onPressed();
                widget.onPressSkip();
              },

              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  height: h2,
                  width: h2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.index == 2 ? 'Skip' : 'Next',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
