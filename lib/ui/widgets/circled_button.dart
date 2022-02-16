import 'package:flutter/material.dart';

class CircledButton extends StatelessWidget {
  const CircledButton(
      {Key? key,
      required this.iconData,
      required this.onPressed,
      required this.backgroundColor,
      required this.hoverColor,
      required this.elevation,
      required this.width,
      required this.splashColor})
      : super(key: key);
  final IconData iconData;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color splashColor;
  final Color hoverColor;
  final double elevation;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Icon(
        iconData,
        // size: 0.02 * width,
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
        elevation: MaterialStateProperty.all<double>(elevation),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return splashColor;
          } else {
            return hoverColor;
          }
        }),
      ),
    );
  }
}
