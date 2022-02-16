import 'package:flutter/material.dart';
import 'package:brain_game/ui/widgets/eraser.dart';
import 'package:brain_game/ui/widgets/pencil.dart';
import 'package:brain_game/ui/widgets/ruler.dart';
import 'package:brain_game/utils/breakpoints.dart';

class Stationery extends StatelessWidget {
  const Stationery({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (width >= Preakpoints.md) ? 0.18 * width : 0.08 * width,
      bottom: (width >= Preakpoints.md) ? 0.18 * width : 0.25 * width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Eraser(
            width: width,
          ),
          SizedBox(width: width * 0.01),
          Ruler(
            width: width,
          ),
          SizedBox(width: width * 0.02),
          Pencil(width: width),
        ],
      ),
    );
  }
}
