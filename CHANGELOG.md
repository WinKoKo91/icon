# 🙋‍♂️ Icon
## **[2.2.1] - 27 APR 21**
- Removing references to deprecated ~~trueSize~~.

## **[2.2.0] - 27 APR 21**
- 🆕 methods for an `IconToo` offering 📋 `copyWith` and `operator` overrides:
  - 👆➕➖❌💥🧦 (see documentation)
  - Especially exciting is 👆 `IconButton operator >(VoidCallback onTap)`
  - And 💥 `Icon`/`IconToo operator %(dynamic modulate)` is neat for super simple randoms
  - The `Padding` provided by 🧦 `Widget operater &(dynamic padding)` could use a better emoji. (They don't need any.)

- Private fields introduced for `_sizeX` and `_sizeY` that may be initialized with the constructor.
  - Now the new `sizeX` and `sizeY` fields are getters only that look to `_trueSize`, then to `_sizeX` and `_sizeY`.
  - This means these getters always represent the *true* size for the `IconToo`, as they consider all sizing options.
    - `Size trueSize` maintained for now, but is ***`deprecated`*** and a private field with no getter.
    - If initialized, constructor `double? sizeX ?? double? sizeY` is passed to `super Icon` as `Icon.size`
      - New constructor `IconToo.tall` for `sizeY ?? sizeX` initialization
    - Made the `copyWith` methods cleaner/simpler to implement.

## **[2.1.0] - 25 APR 21**
- 🆕 `sizeX` and `sizeY` params for `const` creation with `double`s
- 🆕 Support for overriding `AlignmentGeometry` as `IconToo.alignment`.
  - Defaults to side-align by `Directionality.of` because `IconToo` is `trueSize`d by design.

- An `extension on Icon` called 🗜️ `IconUtils` deployed:
  - 📋 `copyWith`
  - ❌ `operator *(dynamic operation)`
    - `operation is Color` `=>` `this.copyWith(color:operation)`
    - `operation is double` `=>` `this.copyWith(size: size ?? 0 * operation)`
  - ➕ `operator +(double inflate)`
  - ➖ `operator -(double deflate)`

## **[2.0.0+4] - 05 APR 21**
- Null-safe IconToo.

## **[1.0.1+3] - 26 FEB 21**
- Between 0.1.0 and 1.0.0, parameter `trueSize` had its `@required`ment removed, but the README and documentation did not reflect this.

## **[1.0.0+2] - 25 FEB 21**
- Added a [second demo](https://github.com/Zabadam/icon_too/blob/main/example/lib/main.dart#L114 'AppBar leading icon in Icon Example app') to the Icon Example app.
- Looked back at the base [`Icon`](https://api.flutter.dev/flutter/widgets/Icon-class.html 'Flutter API: Icon') class and recognized that [`IconToo`](https://pub.dev/documentation/icon/latest/icon/IconToo-class.html 'Flutter API: IconToo') ought to support [`TextDirection`](https://api.flutter.dev/flutter/intl/TextDirection-class.html 'Flutter API: TextDirection'), allow a [`Key`](https://api.flutter.dev/flutter/foundation/Key/Key.html 'Flutter API: Key') initialization, and properly accept and pass a [`semanticLabel`](https://pub.dev/documentation/icon/latest/icon/IconToo/semanticLabel.html 'Icon API: semanticLabel').

- Altered some documentation based on hover hints and DartDoc.
- Updated [README](https://github.com/Zabadam/icon_too#%EF%B8%8F-im-an-icon-too 'Icon Example directory') presentation and sample code.

## **[0.1.0+1] - 25 FEB 21**
- Initial release, forked from a primary project.
