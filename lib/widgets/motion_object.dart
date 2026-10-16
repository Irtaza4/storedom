import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../art.dart';

/// Isolates paint from animation: only the perspective transform changes per tick.
/// Pointer position adds a gentle tilt; reduced motion disables all movement.
class MotionObject extends StatefulWidget {
  final int kind;
  final Color? color;
  final double phase, amplitude;
  const MotionObject({
    super.key,
    required this.kind,
    this.color,
    this.phase = 0,
    this.amplitude = 8,
  });
  @override
  State<MotionObject> createState() => _MotionObjectState();
}

class _MotionObjectState extends State<MotionObject>
    with SingleTickerProviderStateMixin {
  late final AnimationController _float = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 5000 + widget.kind * 650),
  );
  Offset _pointer = Offset.zero;
  bool _reduced = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduced = MediaQuery.disableAnimationsOf(context);
    if (_reduced) {
      _float.stop();
    } else {
      _float.repeat();
    }
  }

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, bounds) => MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        if (!_reduced) {
          setState(
            () => _pointer = Offset(
              event.localPosition.dx / bounds.maxWidth - .5,
              event.localPosition.dy / bounds.maxHeight - .5,
            ),
          );
        }
      },
      onExit: (_) => setState(() => _pointer = Offset.zero),
      child: AnimatedBuilder(
        animation: _float,
        child: RepaintBoundary(
          child: ObjectArt(kind: widget.kind, color: widget.color),
        ),
        builder: (_, child) {
          final wave = _reduced
              ? 0.0
              : math.sin(_float.value * math.pi * 2 + widget.phase);
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, .0015)
              ..translateByDouble(0, wave * widget.amplitude, 0, 1)
              ..rotateX(_pointer.dy * -.18)
              ..rotateY(_pointer.dx * .28)
              ..rotateZ(wave * .035),
            child: child,
          );
        },
      ),
    ),
  );
}
