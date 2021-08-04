# 🙋‍♂️ I'm an `IconToo`!

### An extended [`Icon`](https://pub.dev/documentation/icon/latest/icon/ 'icon 📖 Documentation') "too" for those that are not actually square, plus 👥 [`shadows`](https://pub.dev/documentation/icon/latest/icon/IconToo/shadows.html 'Icon API: shadows') support.

> ##### **WORK IN PROGRESS**
> ## + 🗜️ `extension IconUtils on Icon`

&nbsp;

[![Screenshot preview of Icon Example app](https://github.com/Zabadam/icon_too/blob/main/doc/IconToo_Example_thumb.png?raw=true)](https://github.com/Zabadam/icon_too/blob/main/doc/IconToo_Example.png?raw=true 'Fullsize')[![Screenshot preview of Icon Example app](https://github.com/Zabadam/icon_too/blob/main/doc/IconToo_Example_Demo2_thumb.png?raw=true)](https://github.com/Zabadam/icon_too/blob/main/doc/IconToo_Example_Demo2.png?raw=true 'Fullsize')

... because Flutter's native [`Icon`](https://api.flutter.dev/flutter/widgets/Icon-class.html 'Flutter API: Icon') ["assumes that the rendered icon is squared"](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24) and that ["non-squared icons may render incorrectly."](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L25)

```dart
const IconToo(IconData icon, {Key? key, 🕳️, double? sizeX, double? sizeY,
    Color? color, List<Shadow>? shadows, AlignmentGeometry? alignment,
    String? semanticLabel, TextDirection? textDirection})
```
> ## 🕳️
> #### Deprecated. Adopt `double`s [`sizeX`](https://pub.dev/documentation/icon/latest/icon/IconToo/sizeX.html 'Icon API: sizeX') and [`sizeY`](https://pub.dev/documentation/icon/latest/icon/IconToo/sizeY.html 'Icon API: sizeY').
> ### ~~```Size? trueSize```~~

&nbsp;

Builds an [`Icon`](https://api.flutter.dev/flutter/widgets/Icon-class.html 'Flutter API: Icon')-akin widget set inside a [`SizedBox`](https://api.flutter.dev/flutter/widgets/SizedBox-class.html 'Flutter API: SizedBox') constrained by [`sizeX`](https://pub.dev/documentation/icon/latest/icon/IconToo/sizeX.html 'Icon API: sizeX') and [`sizeY`](https://pub.dev/documentation/icon/latest/icon/IconToo/sizeY.html 'Icon API: sizeY') with given [`icon`](https://pub.dev/documentation/icon/latest/icon/IconToo/icon.html 'Icon API: icon') data.

Customize with 🎨 [`color`](https://pub.dev/documentation/icon/latest/icon/IconToo/color.html 'Icon API: color'), which defaults to [`IconTheme.of`](https://api.flutter.dev/flutter/widgets/IconTheme/of.html 'Flutter API: IconTheme.of'), or optional 👥 [`shadows`](https://pub.dev/documentation/icon/latest/icon/IconToo/shadows.html 'Icon API: shadows'), a `List<Shadow>` like `TextStyle.shadows`.

The `AlignmentGeometry` and [`textDirection`](https://pub.dev/documentation/icon/latest/icon/IconToo/textDirection.html 'Icon API: textDirection') are handled, but may be overridden if necessary.
- See [`alignment`](https://pub.dev/documentation/icon/latest/icon/IconToo/alignment.html 'Icon API: alignment') for more information.

Replete with proper [`Semantics`](https://api.flutter.dev/flutter/widgets/Semantics-class.html 'Flutter API: Semantics') and [debug `Property`s](https://api.flutter.dev/flutter/foundation/DoubleProperty-class.html 'Flutter API: DoubleProperty').


> ***NOTE:***
> *All the boxes are checked as far as the parameters for which a standard [`Icon`](https://api.flutter.dev/flutter/widgets/Icon-class.html 'Flutter API: Icon') looks and the accessibility & debug features they offer.*
>
> *As a design choice, the `super` [`Icon`](https://api.flutter.dev/flutter/widgets/Icon-class.html 'Flutter API: Icon') receives* `this` `IconToo`'s initialized `sizeX ?? sizeY`, *if any,* as [`Icon.size`](https://api.flutter.dev/flutter/widgets/Icon/size.html 'Flutter API: Icon.size property').
> - *This assignment behavior can be reversed to `sizeY ?? sizeX` by using the [`IconToo.tall`]() constructor.*
>
> ***SEE ALSO:***
> *[`Icon`](https://api.flutter.dev/flutter/widgets/Icon-class.html 'Flutter API: Icon'), for a description on what an "[`Icon`](https://api.flutter.dev/flutter/widgets/Icon-class.html 'Flutter API: Icon')" **is** and some requirements to deploy that `Widget` or an 🙋‍♂️ `IconToo`.*

&nbsp;

## ❓ `IconToo` as [`IconButton`](https://api.flutter.dev/flutter/material/IconButton-class.html 'Flutter API: IconButton'):
```dart
final wideButton = IconButton(
  icon: const IconToo(
    CustomIcons.non_square_icon,
    // IconToo passes `fontSize: min(sizeX, sizeY)`,
    // the shortest side (here: height), to glyph-rendering TextStyle:
    sizeX: 34.0 * 5.0, // Glyph is 5 times wider than tall
    sizeY: 34.0,
  ),
  // But the max(), or longest side, is needed to ensure an
  // IconButton has a diameter that encompasses the entire IconToo:
  iconSize: 34.0 * 5.0, // IconToo.asSize.longestSize
  onPressed: () {},
);
```

## ❓ [Example App](https://github.com/Zabadam/icon_too/tree/main/example)
See some example usage of the `icon` package:
- [Icon Example Android source](https://github.com/Zabadam/icon_too/tree/main/example/lib/main.dart): `/example/lib/main.dart`
- [Icon Example APK](https://github.com/Zabadam/icon_too/tree/main/example/build/app/outputs/flutter-apk/app-release.apk)

&nbsp;

## 🗜️ Icon Utilities
Icon Example - [Demo 3: 🗜️ `Icon` `Operator` Utilities](https://github.com/Zabadam/icon_too/tree/main/example/lib/demo3.dart): `/example/lib/demo3.dart`
- 📋 `copyWith` optional replacement values
- 👆 `operator >(VoidCallback onTap)` ➡ `IconButton`
- ➕ `operator +(inflate)` ➡ `size += inflation`
- ➖ `operator -(deflate)` ➡ `size -= deflation`
- ❌ `operator *(dynamic operation)`
  - ❓ `operation is Color` ➡ `color = operation`
  - ❓ `operation is double` ➡ `size *= operation`
- 🧦 `operator &(dynamic padding)`
  - ❓ `padding is num` ➡ `EdgeInsets.all(padding)`
  - ❓ `padding is List<num>` (length==2) ➡ `EdgeInsets.symmetric(horizontal: padding[0], vertical: padding[1])`
  - ❓ `padding is List<num>` (length==4) ➡ `EdgeInsets.fromLTRB(padding[0], padding[1],padding[2], padding[3])`

## 🗜️ IconToo Utilities
Icon Example - [Demo 3: 🗜️ `Icon` `Operator` Utilities](https://github.com/Zabadam/icon_too/tree/main/example/lib/demo3.dart): `/example/lib/demo3.dart`
- 📋 `copyWith` optional replacement values
- 👆 `operator >(VoidCallback onTap)` ➡ `IconButton`
- ➕ `operator +(inflate)` ➡ `sizeX += inflation` & `sizeY += inflation`
  - ❓ `inflation is num`: adds to `sizeX` & `sizeY` the same
  - ❓ `inflation is List<num>` (length==2): ramps `X += inflation[0]` & `Y += inflation[1]`
- ➖ `operator -(deflate)` ➡ `sizeX -= deflation` & `sizeY -= deflation`
  - ❓ `deflation is num`: subtracts from `sizeX` & `sizeY` the same
  - ❓ `deflation is List<num>` (length==2): ramps `X -= deflation[0]` & `Y -= deflation[1]`
- ❌ `operator *(dynamic operation)`
  - ❓ `operation is Color` ➡ `color = operation`
  - ❓ `operation is num`: multiplies `sizeX` & `sizeY` the same
  - ❓ `operation is List<num>` (length==2): ramps `X *= operation[0]` & `Y *=operation[1]`
- 🧦 `operator &(dynamic padding)`
  - ❓ `padding is num` ➡ `EdgeInsets.all(padding)`
  - ❓ `padding is List<num>` (length==2) ➡ `EdgeInsets.symmetric(horizontal: padding[0], vertical: padding[1])`
  - ❓ `padding is List<num>` (length==4) ➡ `EdgeInsets.fromLTRB(padding[0], padding[1],padding[2], padding[3])`


Nearly every `IconToo` `operator` works the same in [`IconUtils`]() as well.
The only differences (currently) are [`IconToo.+`](), [`IconToo.-`](), [`IconToo.*`](), all of which additionally (over [`IconUtils`]())
accept a `List<num>` of `length==2` where the first value applies to `IconToo.sizeX` and the second value to `IconToo.sizeY`.
