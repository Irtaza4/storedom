import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final font = FontLoader('Manrope');
  for (final weight in [400, 600, 700, 800]) {
    font.addFont(
      Future.value(
        ByteData.sublistView(
          File('assets/fonts/Manrope-$weight.ttf').readAsBytesSync(),
        ),
      ),
    );
  }
  await font.load();
  final icons = FontLoader('MaterialIcons');
  icons.addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
  await icons.load();
  for (final family in ['SpaceGrotesk', 'DMMono']) {
    final loader = FontLoader(family);
    for (final file
        in family == 'DMMono'
            ? ['DMMono.ttf']
            : ['SpaceGrotesk-500.ttf', 'SpaceGrotesk-700.ttf']) {
      loader.addFont(
        Future.value(
          ByteData.sublistView(File('assets/fonts/$file').readAsBytesSync()),
        ),
      );
    }
    await loader.load();
  }
  await testMain();
}
