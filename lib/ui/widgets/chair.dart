import 'package:flutter/material.dart';
import 'package:brain_game/utils/breakpoints.dart';
import 'package:brain_game/utils/game_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chair extends StatelessWidget {
  const Chair({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.404 * width,
      child: SvgPicture.asset(
        GameAssets.chair,
        width: (width >= Preakpoints.md) ? 0.18 * width : 0.2 * width,
      ),
    );
  }
}
