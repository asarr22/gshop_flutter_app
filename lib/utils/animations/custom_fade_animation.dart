import 'package:flutter/material.dart';

class FadeTranslateAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  const FadeTranslateAnimation({super.key, required this.child, required this.delay});

  @override
  // ignore: library_private_types_in_public_api
  _FadeTranslateAnimationState createState() => _FadeTranslateAnimationState();
}

class _FadeTranslateAnimationState extends State<FadeTranslateAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _translateAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.delay),
      vsync: this,
    )..forward();

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _translateAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _translateAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
