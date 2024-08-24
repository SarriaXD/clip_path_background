import 'dart:math' as math;

import 'package:flutter/material.dart';

class _CurvedClipper extends CustomClipper<Path> {
  const _CurvedClipper({
    required this.iconSize,
    required this.iconOffsetX,
    required this.iconOffsetY,
    required this.iconSpacing,
  });
  final double iconSize;
  final double iconOffsetX;
  final double iconOffsetY;
  final double iconSpacing;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    // Draw left side of the background
    path.lineTo(0, size.height - iconSize / 2);
    // Draw top left corner of the background
    path.arcTo(
      Rect.fromCircle(
        center: Offset(iconSize / 2, iconSize / 2),
        radius: iconSize / 2,
      ),
      1 * math.pi,
      0.5 * math.pi,
      false,
    );
    final centerX = size.width - iconSize / 2 + iconOffsetX;
    final centerY = iconSize / 2 + iconOffsetY;
    final radius = iconSize / 2 + iconSpacing;
    // top edge of the background
    path.lineTo(centerX - radius * 1.8, 0);
    // first curve
    path.cubicTo(
      centerX - radius * 1.8,
      0,
      centerX - radius,
      0,
      centerX - radius,
      centerY,
    );
    // second curve
    path.arcTo(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      math.pi,
      -0.5 * math.pi,
      false,
    );
    // third curve
    path.cubicTo(
      size.width,
      centerY + radius,
      size.width,
      centerY + radius * 1.5,
      size.width,
      centerY + radius * 2,
    );
    // right edge of the background
    path.lineTo(size.width, size.height);
    // bottom edge of the background
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>
      oldClipper != this;
}

class _ClippedBackground extends StatelessWidget {
  const _ClippedBackground({
    required this.background,
    required this.iconSize,
    required this.iconOffsetX,
    required this.iconOffsetY,
    required this.iconSpacing,
  });

  final Widget background;
  final double iconSize;
  final double iconOffsetX;
  final double iconOffsetY;
  final double iconSpacing;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CurvedClipper(
        iconSize: iconSize,
        iconOffsetX: iconOffsetX,
        iconOffsetY: iconOffsetY,
        iconSpacing: iconSpacing,
      ),
      child: background,
    );
  }
}

// this is the main widget
class ClippedBackgroundWithIcon extends StatelessWidget {
  const ClippedBackgroundWithIcon({
    super.key,
    required this.icon,
    required this.background,
    required this.iconSize,
    required this.iconOffsetX,
    required this.iconOffsetY,
    required this.iconSpacing,
  });

  final Widget icon;
  final Widget background;
  final double iconSize;
  final double iconOffsetX;
  final double iconOffsetY;
  final double iconSpacing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _ClippedBackground(
          background: background,
          iconSize: iconSize,
          iconOffsetX: iconOffsetX,
          iconOffsetY: iconOffsetY,
          iconSpacing: iconSpacing,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Transform.translate(
            offset: Offset(iconOffsetX, iconOffsetY),
            child: SizedBox(
              width: iconSize,
              height: iconSize,
              child: icon,
            ),
          ),
        ),
      ],
    );
  }
}
