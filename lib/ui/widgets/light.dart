import 'package:flutter/material.dart';
import 'package:brain_game/utils/breakpoints.dart';
import 'package:brain_game/utils/game_assets.dart';

class TraingleLight extends StatefulWidget {
  const TraingleLight({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  State<TraingleLight> createState() => TraingleLightState();
}

class TraingleLightState extends State<TraingleLight>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _colorTween = ColorTween(
            begin: const Color(0xffe8c193).withOpacity(0.0),
            end: Colors.yellow.withOpacity(0.4))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void switchLight() async {
    if (_animationController.isDismissed) {
      await GameAssets.pool.play(GameAssets.turnOnSoundId);
      _animationController.forward(from: 0);
    } else if (_animationController.isCompleted) {
      await GameAssets.pool.play(GameAssets.turnOffSoundId);
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (widget.width >= Preakpoints.md)
          ? widget.width * 0.24
          : widget.width * 0.19,
      bottom: (widget.width >= Preakpoints.md)
          ? widget.width * 0.264
          : widget.width * 0.362,
      child: IgnorePointer(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateZ(20),
          child: SizedBox(
            child: AnimatedBuilder(
              builder: (context, _) {
                return CustomPaint(
                  painter: LightPainter(color: _colorTween.value),
                  size: Size(
                    (widget.width >= Preakpoints.md)
                        ? 0.19 * widget.width
                        : 0.21 * widget.width,
                    (widget.width >= Preakpoints.md)
                        ? 0.19 * widget.width
                        : 0.21 * widget.width,
                  ),
                );
              },
              animation: _colorTween,
            ),
          ),
        ),
      ),
    );
  }
}

class LightPainter extends CustomPainter {
  late final Paint painter;
  final Color color;
  LightPainter({required this.color}) {
    painter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
