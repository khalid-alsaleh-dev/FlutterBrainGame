import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brain_game/utils/breakpoints.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brain_game/utils/game_assets.dart';

class Ruler extends StatefulWidget {
  const Ruler({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  State<Ruler> createState() => _RulerState();
}

class _RulerState extends State<Ruler> with SingleTickerProviderStateMixin {
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
    return MouseRegion(
      onHover: (_) {
        _animationController.forward();
      },
      onExit: (_) {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ((-pi / 10))
                  ..rotateX((-pi / 5) * _rotationAnimation.value),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      width: (widget.width >= Preakpoints.md)
                          ? 0.04 * widget.width
                          : 0.05 * widget.width,
                      height: 8,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 0.4,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      GameAssets.ruler,
                      width: (widget.width >= Preakpoints.md)
                          ? 0.05 * widget.width
                          : 0.05 * widget.width,
                    ),
                  ],
                ));
          }),
    );
  }
}
