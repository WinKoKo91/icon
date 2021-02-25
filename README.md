# 🙋‍♂️ I'm an Icon Too!

## An extended Icon for those that are not actually square.

```dart
const IconToo(IconData icon, {@required Size trueSize, Color color})
```

Builds an [Icon] set inside a [SizedBox] constrained by [trueSize], with given data [icon] and optionally passing [color].

## Example usage with an [IconButton]:

```dart
IconButton(
  icon: IconToo(
    color: Colors.red,
    CustomIcons.non_square_icon,
    // IconToo passes `iconSize = min(trueSize.width, trueSize.height)` to `Icon(size: iconSize)`
    trueSize: Size(34.0 * 5, 34.0),
  ),
  // But we need the max() to ensure an IconButton has a diameter that encompasses the entire IconToo
  iconSize: 34.0 * 5,
  onPressed: () {},
);
```


## TODO:
### [IconToo Example](https://github.com/Zabadam/icon_too/tree/main/example)

See some example usage of the IconToo package for Flutter included here.
- [IconToo Example Android source](https://github.com/Zabadam/icon_too/tree/main/example/lib/main.dart): `/example/lib/main.dart`
- [IconToo Example APK](https://github.com/Zabadam/icon_too/tree/main/example/build/app/outputs/flutter-apk/app-release.apk)
