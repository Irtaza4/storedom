import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/common.dart';
import '../widgets/motion_object.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const SplashScreen({super.key, required this.onComplete});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _intro =
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2600),
      )..addStatusListener((status) {
        if (status == AnimationStatus.completed) _finish();
      });
  bool _finished = false;
  void _finish() {
    if (_finished) return;
    _finished = true;
    widget.onComplete();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _intro.duration = const Duration(milliseconds: 300);
    }
    _intro.forward();
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: night,
    body: SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 24,
            left: 28,
            child: Text(
              'A NEW PERSPECTIVE ON EVERYDAY.',
              style: mono(color: Colors.white54, size: 9),
            ),
          ),
          Positioned(
            top: 8,
            right: 16,
            child: TextButton(
              onPressed: _finish,
              child: const ArrowLabel('Enter', style: TextStyle(color: lime)),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 260,
                  height: 260,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 210,
                          height: 210,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white12),
                          ),
                        ),
                      ),
                      const MotionObject(
                        kind: 0,
                        color: Color(0xFFBDA5EB),
                        amplitude: 14,
                      ),
                    ],
                  ),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: .8, end: 1),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutBack,
                  builder: (_, v, child) =>
                      Transform.scale(scale: v, child: child),
                  child: const Brand(color: lime, size: 86),
                ),
                const SizedBox(height: 18),
                Text(
                  'UNUSUALLY GOOD OBJECTS.',
                  style: mono(color: Colors.white70, size: 11),
                ),
              ],
            ),
          ),
          Positioned(
            left: 32,
            right: 32,
            bottom: 35,
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _intro,
                  builder: (_, _) => LinearProgressIndicator(
                    value: _intro.value,
                    minHeight: 2,
                    color: lime,
                    backgroundColor: Colors.white12,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'A LITTLE OUT OF THE ORDINARY',
                      style: mono(color: Colors.white38, size: 8),
                    ),
                    Text(
                      'EST. 2026',
                      style: mono(color: Colors.white38, size: 8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
