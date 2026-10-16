import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store/main.dart';
import 'package:store/widgets/motion_object.dart';

void main() {
  Future<void> launch(
    WidgetTester tester, {
    bool splash = false,
    bool reduced = true,
  }) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        FakeAccessibilityFeatures(disableAnimations: reduced);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await tester.pumpWidget(MyApp(showSplash: splash));
    await tester.pump();
  }

  testWidgets('Product options, shared favorites, bag and demo checkout', (
    tester,
  ) async {
    await launch(tester);
    await tester.tap(find.byTooltip('Search objects'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Cloud headphones');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cloud headphones').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save Cloud headphones'));
    await tester.tap(find.bySemanticsLabel('Rose'));
    await tester.tap(find.byTooltip('Increase quantity'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to bag · \$258'));
    await tester.pumpAndSettle();
    expect(find.text('Added to your bag ✓'), findsOneWidget);
    await tester.tap(find.byTooltip('Back to store'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Saved'));
    await tester.pumpAndSettle();
    expect(find.text('Cloud headphones'), findsOneWidget);
    await tester.tap(find.text('Bag · 2'));
    await tester.pumpAndSettle();
    expect(find.text('ROSE'), findsOneWidget);
    await tester.tap(find.byTooltip('Decrease Cloud headphones'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Make it yours'));
    await tester.tap(find.text('Make it yours'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Place demo order'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter your full name'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), 'Alex Test');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'alex@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(2), '123 Demo Street');
    await tester.ensureVisible(find.text('Place demo order'));
    await tester.tap(find.text('Place demo order'));
    await tester.pumpAndSettle();
    expect(find.text('Excellent taste.\nGreat choice.'), findsOneWidget);
    await tester.tap(find.text('Keep discovering'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bag'));
    await tester.pumpAndSettle();
    expect(find.text('Room for something odd.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Splash completes and collections filter the catalogue', (
    tester,
  ) async {
    await launch(tester, splash: true);
    expect(find.text('UNUSUALLY GOOD OBJECTS.'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Less ordinary.\nMore you.'), findsOneWidget);
    await tester.tap(find.text('Edits'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tech'));
    await tester.pumpAndSettle();
    expect(find.text('The Tech edit.'), findsOneWidget);
    expect(find.text('Cloud headphones'), findsOneWidget);
    expect(find.text('Shroom lamp'), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Objects animate and reduced motion freezes transforms', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(width: 240, height: 240, child: MotionObject(kind: 0)),
        ),
      ),
    );
    await tester.pump();
    final before = tester
        .widget<Transform>(
          find
              .descendant(
                of: find.byType(MotionObject),
                matching: find.byType(Transform),
              )
              .first,
        )
        .transform
        .clone();
    await tester.pump(const Duration(milliseconds: 800));
    expect(
      tester
          .widget<Transform>(
            find
                .descendant(
                  of: find.byType(MotionObject),
                  matching: find.byType(Transform),
                )
                .first,
          )
          .transform,
      isNot(before),
    );
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    await tester.pump();
    final stopped = tester
        .widget<Transform>(
          find
              .descendant(
                of: find.byType(MotionObject),
                matching: find.byType(Transform),
              )
              .first,
        )
        .transform
        .clone();
    await tester.pump(const Duration(seconds: 1));
    expect(
      tester
          .widget<Transform>(
            find
                .descendant(
                  of: find.byType(MotionObject),
                  matching: find.byType(Transform),
                )
                .first,
          )
          .transform,
      stopped,
    );
    tester.platformDispatcher.clearAccessibilityFeaturesTestValue();
  });
}
