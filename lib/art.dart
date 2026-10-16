import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Offline vector illustrations with studio lighting and cast shadows.
class ObjectArt extends StatelessWidget {
  final int kind;
  final Color? color;
  const ObjectArt({super.key, required this.kind, this.color});
  @override
  Widget build(BuildContext context) => Semantics(
    label: [
      'Sculptural over-ear headphones',
      'Mushroom table lamp',
      'Rounded portable speaker',
      'Curved lounge chair',
    ][kind],
    image: true,
    child: CustomPaint(
      painter: _ObjectPainter(kind, color),
      size: Size.infinite,
    ),
  );
}

class _ObjectPainter extends CustomPainter {
  final int kind;
  final Color? tint;
  _ObjectPainter(this.kind, this.tint);
  Color light(Color c, double t) => Color.lerp(c, Colors.white, t)!;
  Color dark(Color c, double t) => Color.lerp(c, const Color(0xFF21162F), t)!;
  Paint gradient(
    Rect r,
    List<Color> colors, {
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
  }) => Paint()
    ..shader = LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
    ).createShader(r);
  void rounded(Canvas c, Rect r, double radius, List<Color> colors) =>
      c.drawRRect(
        RRect.fromRectAndRadius(r, Radius.circular(radius)),
        gradient(r, colors),
      );
  @override
  void paint(Canvas canvas, Size size) {
    final scale = math.min(size.width / 260, size.height / 260);
    canvas.save();
    canvas.translate(
      (size.width - 260 * scale) / 2,
      (size.height - 260 * scale) / 2,
    );
    canvas.scale(scale);
    canvas.drawOval(
      const Rect.fromLTWH(49, 222, 168, 17),
      Paint()
        ..color = const Color(0xFF32233C).withValues(alpha: .2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );
    switch (kind) {
      case 0:
        headphones(canvas);
      case 1:
        lamp(canvas);
      case 2:
        speaker(canvas);
      case 3:
        chair(canvas);
    }
    canvas.restore();
  }

  void headphones(Canvas c) {
    final base = tint ?? const Color(0xFFAB8BCB);
    c.save();
    c.translate(130, 127);
    c.rotate(-.14);
    c.translate(-130, -127);
    final band = Path()
      ..moveTo(62, 152)
      ..cubicTo(23, 13, 218, -9, 208, 141);
    c.drawPath(
      band,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 28
        ..strokeCap = StrokeCap.round
        ..color = dark(base, .42),
    );
    c.drawPath(
      band,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 21
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(
          colors: [light(base, .48), base, dark(base, .22)],
        ).createShader(const Rect.fromLTWH(35, 20, 180, 140)),
    );
    final shine = Path()
      ..moveTo(51, 100)
      ..cubicTo(42, 34, 141, 3, 185, 59);
    c.drawPath(
      shine,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..color = light(base, .65).withValues(alpha: .8),
    );
    rounded(c, const Rect.fromLTWH(46, 117, 16, 68), 7, [
      light(base, .5),
      dark(base, .2),
    ]);
    rounded(c, const Rect.fromLTWH(196, 109, 15, 65), 6, [
      light(base, .4),
      dark(base, .25),
    ]);
    c.save();
    c.translate(70, 170);
    c.rotate(-.18);
    rounded(c, const Rect.fromLTWH(-30, -47, 61, 103), 28, [
      dark(base, .18),
      dark(base, .64),
    ]);
    rounded(c, const Rect.fromLTWH(-31, -47, 43, 100), 23, [
      light(base, .55),
      base,
      dark(base, .2),
    ]);
    c.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-25, -38, 26, 80),
        const Radius.circular(18),
      ),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = light(base, .6),
    );
    c.restore();
    c.save();
    c.translate(186, 162);
    c.rotate(.17);
    rounded(c, const Rect.fromLTWH(-27, -43, 64, 107), 29, [
      dark(base, .65),
      dark(base, .2),
    ]);
    rounded(c, const Rect.fromLTWH(-8, -46, 52, 106), 25, [
      light(base, .62),
      base,
      dark(base, .28),
    ]);
    rounded(c, const Rect.fromLTWH(1, -36, 35, 86), 19, [
      light(base, .36),
      base,
    ]);
    c.drawLine(
      const Offset(32, 7),
      const Offset(32, 23),
      Paint()
        ..color = dark(base, .23)
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
    c.drawCircle(const Offset(19, 41), 2, Paint()..color = light(base, .85));
    c.restore();
    c.restore();
  }

  void lamp(Canvas c) {
    final base = tint ?? const Color(0xFFE4A64A);
    final stem = Path()
      ..moveTo(112, 119)
      ..lineTo(104, 208)
      ..quadraticBezierTo(101, 226, 134, 226)
      ..quadraticBezierTo(163, 226, 157, 208)
      ..lineTo(146, 117)
      ..close();
    c.drawPath(
      stem,
      gradient(const Rect.fromLTWH(100, 110, 60, 120), [
        light(base, .65),
        base,
        dark(base, .25),
      ]),
    );
    c.drawOval(
      const Rect.fromLTWH(47, 114, 173, 34),
      gradient(const Rect.fromLTWH(47, 114, 173, 34), [
        dark(base, .35),
        light(base, .35),
      ]),
    );
    final dome = Path()
      ..moveTo(43, 126)
      ..cubicTo(41, 15, 218, 10, 224, 126)
      ..quadraticBezierTo(137, 160, 43, 126)
      ..close();
    c.drawPath(
      dome,
      gradient(const Rect.fromLTWH(43, 37, 181, 111), [
        light(base, .72),
        light(base, .15),
        base,
        dark(base, .24),
      ]),
    );
    final highlight = Path()
      ..moveTo(65, 93)
      ..quadraticBezierTo(77, 52, 118, 49);
    c.drawPath(
      highlight,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round
        ..color = Colors.white.withValues(alpha: .24)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    c.drawOval(
      const Rect.fromLTWH(111, 216, 40, 7),
      Paint()..color = light(base, .35),
    );
  }

  void speaker(Canvas c) {
    final base = tint ?? const Color(0xFF6C9384);
    c.save();
    c.translate(132, 135);
    c.rotate(-.16);
    c.translate(-132, -135);
    rounded(c, const Rect.fromLTWH(48, 51, 169, 165), 58, [
      light(base, .7),
      base,
      dark(base, .4),
    ]);
    rounded(c, const Rect.fromLTWH(49, 55, 146, 158), 53, [
      light(base, .28),
      base,
      dark(base, .17),
    ]);
    c.save();
    c.clipRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(58, 66, 125, 132),
        const Radius.circular(43),
      ),
    );
    for (int x = 60; x < 185; x += 5) {
      for (int y = 67; y < 198; y += 5) {
        c.drawCircle(
          Offset(x.toDouble(), y.toDouble()),
          .8,
          Paint()..color = dark(base, .4).withValues(alpha: .48),
        );
        c.drawCircle(
          Offset(x + .7, y + .7),
          .5,
          Paint()..color = light(base, .65).withValues(alpha: .4),
        );
      }
    }
    c.restore();
    rounded(c, const Rect.fromLTWH(110, 54, 45, 10), 5, [dark(base, .3), base]);
    c.drawLine(
      const Offset(122, 57),
      const Offset(122, 61),
      Paint()
        ..color = Colors.white70
        ..strokeWidth = 1.3,
    );
    c.drawLine(
      const Offset(120, 59),
      const Offset(124, 59),
      Paint()
        ..color = Colors.white70
        ..strokeWidth = 1.3,
    );
    c.drawLine(
      const Offset(139, 59),
      const Offset(144, 59),
      Paint()
        ..color = Colors.white70
        ..strokeWidth = 1.3,
    );
    rounded(c, const Rect.fromLTWH(107, 165, 29, 14), 5, [
      light(base, .6),
      light(base, .2),
    ]);
    c.drawCircle(const Offset(121, 172), 2, Paint()..color = dark(base, .2));
    c.restore();
  }

  void chair(Canvas c) {
    final base = tint ?? const Color(0xFFCC7654);
    rounded(c, const Rect.fromLTWH(58, 164, 20, 64), 9, [
      light(base, .3),
      dark(base, .4),
    ]);
    rounded(c, const Rect.fromLTWH(177, 165, 20, 64), 9, [
      base,
      dark(base, .5),
    ]);
    rounded(c, const Rect.fromLTWH(70, 40, 125, 137), 49, [
      light(base, .5),
      base,
      dark(base, .25),
    ]);
    rounded(c, const Rect.fromLTWH(80, 48, 101, 111), 40, [
      light(base, .34),
      base,
    ]);
    rounded(c, const Rect.fromLTWH(51, 140, 151, 60), 28, [
      light(base, .4),
      base,
      dark(base, .4),
    ]);
    rounded(c, const Rect.fromLTWH(59, 130, 138, 46), 24, [
      light(base, .5),
      base,
    ]);
    final left = Path()
      ..moveTo(59, 180)
      ..cubicTo(30, 184, 30, 105, 57, 102)
      ..cubicTo(82, 99, 79, 151, 88, 169);
    c.drawPath(
      left,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 22
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(
          colors: [light(base, .5), base, dark(base, .25)],
        ).createShader(const Rect.fromLTWH(36, 100, 55, 85)),
    );
    final right = Path()
      ..moveTo(174, 173)
      ..cubicTo(190, 145, 180, 107, 202, 109)
      ..cubicTo(225, 110, 218, 184, 191, 188);
    c.drawPath(
      right,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 22
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(
          colors: [light(base, .55), base, dark(base, .3)],
        ).createShader(const Rect.fromLTWH(170, 100, 47, 88)),
    );
  }

  @override
  bool shouldRepaint(covariant _ObjectPainter oldDelegate) =>
      oldDelegate.kind != kind || oldDelegate.tint != tint;
}
