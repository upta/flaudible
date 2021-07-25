import 'dart:ui';
import 'package:flaudible/data/data.dart';
import 'package:flutter/material.dart';

class DownloadOverlay extends StatelessWidget {
  const DownloadOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _DownloadOverlayPainter(
        color: Theme.of(context).bottomAppBarColor,
      ),
    );
  }
}

class _DownloadOverlayPainter extends CustomPainter {
  _DownloadOverlayPainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.black45,
    );

    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, size.height);
    path.moveTo(size.width, size.height / 2);

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );

    final icon = AudibleIcons.download_arrow;
    final painter = TextPainter(
      textDirection: TextDirection.rtl,
    );

    painter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        color: Colors.white,
        fontSize: size.width * 0.15,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
      ),
    );
    painter.layout();

    painter.paint(
      canvas,
      Offset(
        size.width * 0.79,
        size.height * 0.8,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
