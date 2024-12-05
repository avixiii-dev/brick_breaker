import 'package:flutter/material.dart';

class ButtonAnimator extends StatefulWidget {

  /// child widget
  final Widget child;
  /// animation duration in milliseconds
  final int animationDuration;
  /// recurrent delay duration in milliseconds
  final int recurrentDuration;

  const ButtonAnimator({super.key, required this.child, this.animationDuration = 300, this.recurrentDuration = 2000});

  @override
  ButtonAnimatorState createState() => ButtonAnimatorState();
}

class ButtonAnimatorState extends State<ButtonAnimator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  // late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with 2 seconds duration
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration),
    );

    // Define the scaling animation from 1.0 to 1.5 (up and down)
    _animation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Define the rotation animation with slight left (-0.05 radians) and right (0.05 radians) movement
    // _rotateAnimation = Tween<double>(begin: 0.0, end: 0.05).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: Curves.easeInOut,
    //   ),
    // );

    // Repeat the animation with a delay
    _controller.repeat(reverse: true, period: Duration(milliseconds: widget.recurrentDuration));
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when not in use
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    //   AnimatedBuilder(
    //     animation: _controller,
    //     builder: (context, child) {
    //       return Transform.scale(
    //         scale: _animation.value, // Scale the button
    //         child: Transform.rotate(
    //           angle: _rotateAnimation.value, // Rotate the button
    //           child: widget.child
    //         ),
    //       );
    //     },
    // );
      ScaleTransition(
          scale: _animation,
          child: widget.child
    );
  }
}