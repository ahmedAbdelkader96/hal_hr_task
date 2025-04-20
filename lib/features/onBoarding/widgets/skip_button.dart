import 'package:flutter/material.dart';
import 'package:task/features/onBoarding/widgets/stop_watch_custom_painter.dart';

class SkipButton extends StatefulWidget {
  const SkipButton({
    super.key,
    required this.animationController,
    required this.onPressSkip,
  });

  final AnimationController animationController;
  final Function() onPressSkip;

  @override
  State<SkipButton> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

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
  }

  Future<void> _onPressed() async {
    await _controller.forward();
    await _controller.reverse();
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
                progressAnimation: 1 - widget.animationController.value,
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
                      'Skip',
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
