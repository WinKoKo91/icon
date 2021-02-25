# 🙋‍♂️ I'm an Icon Too!

### An extended Icon for those that are not actually square. Plus shadows support!

![Screenshot preview of Icon Example app](https://github.com/Zabadam/icon_too/blob/main/doc/IconToo_Example.png?raw=true)

... because Flutter's native [Icon] ["assumes that the rendered icon is squared"](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24) and that ["non-squared icons may render incorrectly."](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L25)

```dart
IconToo(IconData icon, {@required Size trueSize, Color color})
```

Builds an [Icon] set inside a [SizedBox] constrained by [trueSize], with given data [icon] and optionally passing [color].

✨ As a bonus, [IconToo] supports the `shadows` parameter from [TextStyle], passed as `List<Shadow>` and rendered under an [IconToo].
* See [Shadow] for more information.

## Example usage with an [IconButton]:

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
