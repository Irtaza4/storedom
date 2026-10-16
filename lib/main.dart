import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/splash_screen.dart';
import 'screens/store_shell.dart';
import 'state/store_controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  final bool showSplash;
  const MyApp({super.key, this.showSplash = true});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final StoreController _store = StoreController();
  late bool _intro = widget.showSplash;
  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ODDLY — Unusually good objects.',
    debugShowCheckedModeBanner: false,
    theme: oddlyTheme,
    home: AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      switchInCurve: Curves.easeOutCubic,
      child: _intro
          ? SplashScreen(
              key: const ValueKey('intro'),
              onComplete: () => setState(() => _intro = false),
            )
          : StoreShell(key: const ValueKey('store'), store: _store),
    ),
  );
}
