import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  final Duration duration;
  final double borderRadius;
  final double scaleFactor;
  final Color? splashColor;
  final Color? highlightColor;
  final BounceAnimationType animationType;

  const Bounce(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 150),
      required this.onTap,
      this.borderRadius = 0,
      this.scaleFactor = 1,
      this.splashColor,
      this.highlightColor,
      this.animationType = BounceAnimationType.doubleWay})
      : super(key: key);

  @override
  BounceState createState() => BounceState();
}

class BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  late double _scale;

  // This controller is responsible for the animation
  late AnimationController _animate;

  //Getting the VoidCallback onPressed passed by the user
  VoidCallback get onPressed => widget.onTap;

  // This is a user defined duration, which will be responsible for
  // what kind of bounce he/she wants
  Duration get userDuration => widget.duration;

  /// Simple getter on widget's scaleFactor
  double get scaleFactor => widget.scaleFactor;

  /// Simple getter on widget's splashColor
  Color? get splashColor => widget.splashColor;

  /// Simple getter on widget's highlightColor
  Color? get highlightColor => widget.highlightColor;

  @override
  void initState() {
    //defining the controller
    _animate = AnimationController(
        vsync: this,
        duration: widget.duration, //This is an initial controller duration
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      }); // Can do something in the listener, but not required
    super.initState();
  }

  @override
  void dispose() {
    // To dispose the controller when not required
    _animate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - (_animate.value * scaleFactor);
    return Transform.scale(
        scale: _scale,
        child: GestureDetector(
          onTap: _onTap,
          child: widget.child,
        ));
  }

  //This is where the animation works out for us
  // Both the animation happens in the same method,
  // but in a duration of time, and our callback is called here as well
  void _onTap() {
    //Firing the animation right away
    if (widget.animationType == BounceAnimationType.doubleWay) {
      _animate.forward().then((value) {
        _animate.reverse().then((value) => onPressed());
      });
    } else {
      _animate.forward().then((value) {
        onPressed();
      });
    }
  }
}

enum BounceAnimationType { doubleWay, singleWay }
