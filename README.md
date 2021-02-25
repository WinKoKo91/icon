# 🙋‍♂️ I'm an Icon Too!

### An extended Icon for those that are not actually square. Plus shadows support!

![Screenshot preview of Icon Example app](https://github.com/Zabadam/icon_too/blob/main/doc/IconToo_Example.png?raw=true)

... because Flutter's native [`Icon`](https://api.flutter.dev/flutter/widgets/Icon-class.html 'Flutter API: Icon') ["assumes that the rendered icon is squared"](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24) and that ["non-squared icons may render incorrectly."](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L25)

```dart
IconToo(IconData icon, {@required Size trueSize, Color color, List<Shadow> shadows})
```

* Builds an [`Icon`](https://api.flutter.dev/flutter/widgets/Icon-class.html 'Flutter API: Icon')
set inside a [`SizedBox`](https://api.flutter.dev/flutter/widgets/SizedBox-class.html 'Flutter API: SizedBox') constrained by [`trueSize`](https://pub.dev/documentation/icon/latest/icon/IconToo/trueSize.html 'Icon API: trueSize'), with given data [`icon`](https://pub.dev/documentation/icon/latest/icon/IconToo/icon.html 'Icon API: icon').

* Optionally pass [`color`](https://pub.dev/documentation/icon/latest/icon/IconToo/color.html 'Icon API: color') or [`shadows`](https://pub.dev/documentation/icon/latest/icon/IconToo/shadows.html 'Icon API: shadows').

 ✨ As a bonus, each IconToo supports the `shadows` parameter from [`TextStyle`](https://api.flutter.dev/flutter/dart-ui/TextStyle-class.html 'Flutter API: TextStyle'), passed as `List<Shadow>` and rendered under an `IconToo`.

 * See [`Shadow`](https://api.flutter.dev/flutter/dart-ui/Shadow-class.html 'Flutter API: Shadow') for more information.

* Replete with proper [`Semantics`](https://api.flutter.dev/flutter/widgets/Semantics-class.html 'Flutter API: Semantics') and [debug `Property`s](https://api.flutter.dev/flutter/foundation/DoubleProperty-class.html 'Flutter API: DoubleProperty').

## ❓ Example usage with an [`IconButton`](https://api.flutter.dev/flutter/material/IconButton-class.html 'Flutter API: IconButton'):

```dart
IconButton(
  icon: IconToo(
    color: Colors.red,
    CustomIcons.non_square_icon,
    // IconToo passes `fontSize = min(trueSize.width, trueSize.height)` to `TextStyle()`
    trueSize: Size(34.0 * 5, 34.0),
  ),
  // But we need the max() to ensure an IconButton has a diameter that encompasses the entire IconToo
  iconSize: 34.0 * 5,
  onPressed: () {},
);
```

## [Icon Example app](https://github.com/Zabadam/icon_too/tree/main/example)

See some example usage of the Icon package for Flutter included here.
- [Icon Example Android source](https://github.com/Zabadam/icon_too/tree/main/example/lib/main.dart): `/example/lib/main.dart`
- [Icon Example APK](https://github.com/Zabadam/icon_too/tree/main/example/build/app/outputs/flutter-apk/app-release.apk)
