import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brain_game/utils/breakpoints.dart';
import 'package:brain_game/utils/game_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Eraser extends StatefulWidget {
  const Eraser({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  State<Eraser> createState() => _EraserState();
}

class _EraserState extends State<Eraser> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _rotationAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _rotationAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return MouseRegion(
            onHover: (_) {
              _animationController.forward();
            },
            onExit: (_) {
              _animationController.reverse();
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ((-pi / 13))
                ..rotateY((-pi / 5) * _rotationAnimation.value),
              child: SvgPicture.asset(
                GameAssets.eraser,
                width: (widget.width >= Preakpoints.md)
                    ? 0.02 * widget.width
                    : 0.02 * widget.width,
              ),
            ),
          );
        });
  }
}
