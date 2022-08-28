import 'package:distributor/conf/style/lib/fonts.dart';
import 'package:flutter/material.dart';

class JourneyControlButton extends StatefulWidget {
  final String label;
  final Color backgroundColor;

  const JourneyControlButton({
    Key key,
    this.backgroundColor = const Color(0xFF4EA217),
    this.label,
  }) : super(key: key);

  @override
  State<JourneyControlButton> createState() => _JourneyControlButtonState();
}

class _JourneyControlButtonState extends State<JourneyControlButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 2).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return Ink(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              border: Border.all(
                width: 2,
                color: Colors.white.withOpacity(0.6),
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                for (int i = 1; i <= 2; i++)
                  BoxShadow(
                      color: Colors.white
                          .withOpacity(_animationController.value / 2),
                      spreadRadius: _animation.value * i)
              ],
            ),
            child: Center(
              child: Text(
                widget.label.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: kFontBoldBody,
                    fontSize: 14,
                    letterSpacing: 1.2),
              ),
            ),
          );
        });
  }
}
