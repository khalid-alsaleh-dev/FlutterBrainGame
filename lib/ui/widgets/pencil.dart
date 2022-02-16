import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brain_game/utils/breakpoints.dart';
import 'package:brain_game/utils/game_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Pencil extends StatefulWidget {
  const Pencil({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  State<Pencil> createState() => _PencilState();
}

class _PencilState extends State<Pencil> with SingleTickerProviderStateMixin {
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
                ..rotateX((-pi / 5) * _rotationAnimation.value),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 0.4,
                    blurRadius: 7,
                    // changes position of shadow
                  ),
                ]),
                child: SvgPicture.asset(
                  GameAssets.pencil,
                  width: (widget.width >= Preakpoints.md)
                      ? 0.01 * widget.width
                      : 0.01 * widget.width,
                ),
              ),
            ),
          );
        });
  }
}
