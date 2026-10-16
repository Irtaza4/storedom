import 'package:flutter/material.dart';

/// Shared route choreography; Heroes keep the object continuous between screens.
Route<T> objectRoute<T>(BuildContext context, Widget screen) {
  final reduced = MediaQuery.disableAnimationsOf(context);
  return PageRouteBuilder<T>(
    transitionDuration: Duration(milliseconds: reduced ? 0 : 650),
    reverseTransitionDuration: Duration(milliseconds: reduced ? 0 : 450),
    pageBuilder: (_, _, _) => screen,
    transitionsBuilder: (_, animation, _, child) {
      final curve = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curve,
        child: SlideTransition(
          position: Tween(
            begin: const Offset(0, .045),
            end: Offset.zero,
          ).animate(curve),
          child: child,
        ),
      );
    },
  );
}
