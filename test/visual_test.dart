import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store/main.dart';

void main() {
  for (final size in [
    const Size(430, 1050),
    const Size(360, 800),
    const Size(1200, 1000),
  ]) {
    testWidgets('ODDLY composition ${size.width}', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );
      await tester.pumpWidget(
        const RepaintBoundary(child: MyApp(showSplash: false)),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MyApp),
        matchesGoldenFile('goldens/oddly-${size.width.toInt()}.png'),
      );
      expect(tester.takeException(), isNull);
    });
  }
}
