# ODDLY

Unusually good objects. A Flutter design store with animated product illustrations, shared-object page transitions, a branded splash, editorial collections, favorites, variant-aware bag and demo checkout.

## Run

```sh
flutter pub get
flutter run
# Browser
flutter run -d chrome
```

## Verify

```sh
flutter analyze
flutter test
flutter build web --no-wasm-dry-run
```

Visual baselines cover 360px, 430px and 1200px widths. To intentionally regenerate them:

```sh
flutter test --update-goldens test/visual_test.dart
```

Read [design.md](design.md) for the visual system, screen map and motion specification. App state lives in `lib/state`, screens in `lib/screens`, shared components in `lib/widgets`, and typography/navigation in `lib/core`.

Fonts and illustrations work offline. Font licenses are in `assets/fonts`. Illustrations are animated 2.5D Canvas artwork. Bag and favorites reset on restart. Checkout is explicitly a demo: no payment, external request or shipment occurs.
