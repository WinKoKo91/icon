/// ## 🙋‍♂️ I'm an Icon Too!
/// **+ 🗜️ `extension IconUtils on Icon` 🔽**
///
/// An extended `Icon` "too" for those that are not actually square,
/// because Flutter's native [Icon] ["assumes that the rendered icon is squared"](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24),
/// plus 👥 [shadows] support.
///
/// ---
///     const IconToo(icon, {key, trueSize?, sizeX?, sizeY?, color?, shadows?, alignment?, semanticLabel?, textDirection?})
///
/// - Builds an `Icon`-akin widget set inside a `SizedBox`
///   of `sizeX` and `sizeY` (or `Size trueSize`) with given `icon` data.
/// - Customize with optional 🎨 `color` or 👥 `shadows`, a `List<Shadow>` like `TextStyle`.
/// - The `alignment` and `textDirection` are handled, but may be overridden if necessary.
/// - Replete with proper [`Semantics`](https://api.flutter.dev/flutter/widgets/Semantics-class.html 'Flutter API: Semantics') and [debug `Property`s](https://api.flutter.dev/flutter/foundation/DoubleProperty-class.html 'Flutter API: DoubleProperty').
///
/// Assumed to be wide, `super` `Icon.size` is assigned `sizeX ?? sizeY`.
/// - This affects situations that look for an `Icon.size`, like `IconButton`
/// - A solution for taller icons exists: `IconToo.tall`
///   - Where the only difference is the order of assignment to `Icon.size`: `sizeY ?? sizeX`
/// ---
/// ## 🗜️ Icon Utilities
/// - 📋 `copyWith` optional replacement values
/// - 👆 `operator >(VoidCallback onTap)` ➡ [IconButton]
/// - ➕ `operator +(inflate)` ➡ `size += inflation`
/// - ➖ `operator -(deflate)` ➡ `size -= deflation`
/// - ❌ `operator *(dynamic operation)`
///   - ❓ `operation is Color` ➡ `color = operation`
///   - ❓ `operation is num` ➡ `size *= operation`
/// - 💥 `operator %(dynamic modulation)`
///   - ❓ `modulation is List<Color>` ➡ `color = modulation[Random()]`
///   - ❓ `modulation is List<num>` ➡ `sizeX *= modulation[random]` & `sizeY *= modulation[random]`
///
/// ## 🗜️ IconToo Utilities
/// 📋 `copyWith`
///
/// 👆 "Chevron" `operator >(VoidCallback onTap)` ➡ [IconButton]
///
/// ➕ "Add" `inflation`
/// - ❓ `inflation is num`: adds to `sizeX` & `sizeY` the same
/// - ❓ `inflation is List<num>` (length==2): ramps `X += inflation[0]` & `Y += inflation[1]`
///
/// ➖ "Subtract" `deflation`
/// - ❓ `deflation is num`: subtracts from `sizeX` & `sizeY` the same
/// - ❓ `deflation is List<num>` (length==2): ramps `X -= deflation[0]` & `Y -= deflation[1]`
///
/// ❌ "Multiply" with `operation`
/// - ❓ `operation is Color`: new `Color`
/// - ❓ `operation is num`: multiplies `sizeX` & `sizeY` the same
/// - ❓ `operation is List<num>` (length==2): ramps `X *= operation[0]` & `Y *=operation[1]`
///
/// 💥 "Modulate" with `modulation` (randomizer)
/// - ❓ `modulation is List<Color>` ➡ `color: modulation[Random()]`
/// - ❓ `modulation is List<num>` ➡ `sizeX *= modulation[Random()]` & `sizeY *= modulation[Random()]` (same `Random`)
///
/// 🧦 "And" with `padding`
/// - ❓ `padding is num` ➡ `EdgeInsets.all(padding)`
/// - ❓ `padding is List<num>` (length==2) ➡ `EdgeInsets.symmetric(horizontal: padding[0], vertical: padding[1])`
/// - ❓ `padding is List<num>` (length==4) ➡ `EdgeInsets.fromLTRB(padding[0], padding[1],padding[2], padding[3])`
///
/// ---
/// ### ❓ [IconToo] as [IconButton]:
/// ```dart
/// final wideButton = IconButton(
///   icon: const IconToo(
///     CustomIcons.non_square_icon,
///     // IconToo passes `fontSize: min(trueSize.width, trueSize.height)`,
///     // the shortest side (here: height), to glyph-rendering TextStyle:
///     sizeX: 34.0 * 5.0,
///     sizeY: 34.0,
///     // trueSize: Size(34.0 * 5.0, 34.0), // this works, too
///   ),
///   // But the max(), or longest side, is needed to ensure an
///   // IconButton has a diameter that encompasses the entire IconToo:
///   iconSize: 34.0 * 5.0, // longest side, here: width
///   onPressed: () {},
/// );
/// ```
library icon;

export 'src/icon_too.dart';
export 'src/utils.dart';
