/// ## 🙋‍♂️ I'm an Icon Too!
/// An extended Icon "too" for those that are not actually square,
/// because Flutter's native `Icon` ["assumes that the rendered icon is squared"](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24),
/// plus 👥 `shadows` support.
///
/// ## + 🗜️ IconToo Utilities
library icon;

import 'dart:math' show Random, min;
import 'package:flutter/rendering.dart'
    show DiagnosticPropertiesBuilder, DoubleProperty;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show IconButton;

/// ## 🙋‍♂️ I'm an Icon Too!
/// An extended `Icon` "too" for those that are not actually square,
/// because Flutter's native [Icon] ["assumes that the rendered icon is squared"](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24),
/// plus 👥 [shadows] support.
/// ---
///     const IconToo(icon, {key, trueSize?, sizeX?, sizeY?, color?, shadows?, alignment?, semanticLabel?, textDirection?})
///
/// Builds an [Icon]-akin widget set inside a [SizedBox] of
/// [sizeX] and [sizeY] with given [icon] data.
///
/// Customize with 🎨 [color], which defaults to [IconTheme.of],
/// or optional 👥 [shadows], a `List<Shadow>` like [TextStyle.shadows].
///
/// The [AlignmentGeometry] and [textDirection] are handled,
/// but may be overridden if necessary.
/// - See [alignment] for more information.
///
/// Assumed to be wide, `super` [Icon.size] is assigned [_sizeX] `??` [_sizeY].
/// - This affects situations that look for an [Icon.size], like [IconButton]
/// - A solution for taller icons exists: [IconToo.tall]
///   - Where the only difference is the order of assignment to [Icon.size]: [_sizeY] `??` [_sizeX]
///
/// Replete with proper [`Semantics`](https://api.flutter.dev/flutter/widgets/Semantics-class.html 'Flutter API: Semantics') and [debug `Property`s](https://api.flutter.dev/flutter/foundation/DoubleProperty-class.html 'Flutter API: DoubleProperty').
///
/// > ***NOTE:***
/// > *All the boxes are checked as far as the parameters for which a*
/// > *standard [Icon] looks and the accessibility & debug features they offer.*
///
/// > ***SEE ALSO:***
/// > *[Icon], for a description on what an "`Icon`" **is** and*
/// > *some requirements to deploy that [Widget] or an 🙋‍♂️ [IconToo].*
class IconToo extends Icon {
  /// ### 🙋‍♂️ I'm an Icon Too!
  /// An extended `Icon` "too" for those that are not actually square,
  /// because Flutter's native [Icon] ["assumes that the rendered icon is squared"](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24),
  /// plus 👥 [shadows] support.
  /// ---
  ///     const IconToo(icon, {key, trueSize?, sizeX?, sizeY?, color?, shadows?, alignment?, semanticLabel?, textDirection?})
  ///
  /// Builds an [Icon]-akin widget set inside a [SizedBox] of
  /// [sizeX] and [sizeY] with given [icon] data.
  ///
  /// Customize with 🎨 [color], which defaults to [IconTheme.of],
  /// or optional 👥 [shadows], a `List<Shadow>` like [TextStyle.shadows].
  ///
  /// The [AlignmentGeometry] and [textDirection] are handled,
  /// but may be overridden if necessary.
  /// - See [alignment] for more information.
  ///
  /// Assumed to be wide, `super` [Icon.size] is assigned [_sizeX] `??` [_sizeY].
  /// - This affects situations that look for an [Icon.size]
  /// - A solution for taller icons exists: [IconToo.tall]
  ///   - Where the only difference is the order of assignment,
  ///   [Icon.size]: [_sizeY] `??` [_sizeX]
  ///
  /// Replete with proper [`Semantics`](https://api.flutter.dev/flutter/widgets/Semantics-class.html 'Flutter API: Semantics') and [debug `Property`s](https://api.flutter.dev/flutter/foundation/DoubleProperty-class.html 'Flutter API: DoubleProperty').
  ///
  /// ---
  /// ### ❓ [IconToo] as [IconButton]:
  /// ```dart
  /// final wideButton = IconButton(
  ///   icon: const IconToo(
  ///     CustomIcons.non_square_icon,
  ///     // IconToo passes `fontSize: min(trueSize.width, trueSize.height)`,
  ///     // the shortest side (here: height), to glyph-rendering TextStyle:
  ///       sizeX: 34.0 * 5.0, // Glyph is 5 times wider than tall
  ///     sizeY: 34.0,
  ///   ),
  ///   // But the max(), or longest side, is needed to ensure an
  ///   // IconButton has a diameter that encompasses the entire IconToo:
  ///   iconSize: 34.0 * 5.0, // IconToo.asSize.longestSize
  ///   onPressed: () {},
  /// );
  /// ```
  /// > ***NOTE:***
  /// > *All the boxes are checked as far as the parameters for which a*
  /// > *standard [Icon] looks and the accessibility & debug features they offer.*
  ///
  /// > ***SEE ALSO:***
  /// > *[Icon], for a description on what an "`Icon`" **is** and*
  /// > *some requirements to deploy that [Widget] or an 🙋‍♂️ [IconToo].*
  const IconToo(
    this.icon, {
    Key? key,
    @Deprecated(_DEPRECATED) Size? trueSize,
    double? sizeX,
    double? sizeY,
    this.color,
    this.shadows,
    this.alignment,
    this.semanticLabel,
    this.textDirection,
  })  : assert((sizeX ?? 0) >= 0 && (sizeY ?? 0) >= 0,
            '[IconToo] > Provide non-negative dimensions.'),
        _sizeX = sizeX,
        _sizeY = sizeY,
        _trueSize = trueSize,
        super(
          icon,
          key: key,
          size: sizeX ?? sizeY, // Assumed to be wider ╠░░░░░░░░╣
          color: color,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );

  /// ### 🙋‍♂️ I'm an Icon Too!
  /// An extended `Icon` "too" for those that are not actually square,
  /// because Flutter's native [Icon] ["assumes that the rendered icon is squared"](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24),
  /// plus 👥 [shadows] support.
  /// ---
  /// This [IconToo] is dictated to be taller than it is wide.
  ///
  /// The default constructor assumes a non-square icon (though the [icon] *may*
  /// be square) is "wider" by assigning `super` [Icon.size]: `sizeX ?? sizeY`.
  ///
  /// The only difference in this [IconToo.tall]
  /// is the order of assignment: `sizeY ?? sizeX`.
  ///
  /// See default constructor [IconToo] for more information.
  const IconToo.tall(
    this.icon, {
    Key? key,
    @Deprecated(_DEPRECATED) Size? trueSize,
    double? sizeX,
    double? sizeY,
    this.color,
    this.shadows,
    this.alignment,
    this.semanticLabel,
    this.textDirection,
  })  : assert((sizeX ?? 0) >= 0 && (sizeY ?? 0) >= 0,
            '[IconToo.tall] > Provide non-negative dimensions.'),
        _sizeX = sizeX,
        _sizeY = sizeY,
        _trueSize = trueSize,
        super(
          icon,
          key: key,
          size: sizeY ?? sizeX, // Dictated as taller ╠░╣
          color: color,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );

  /// 🆔 The icon data to display.
  ///
  /// Available Material icons are described in [Icons], but none found
  /// there are non-square. Only custom icons, such as `CustomIcons` from
  /// [`custom_icons.dart`](///../example/lib/custom_icons.dart)  found in the IconToo Example app,
  /// would contain non-square [IconData].
  ///
  /// The icon ***may*** be `null`, in which case this [Widget]
  /// will render as an empty space of the specified 🧮 [trueSize]
  /// (or [sizeX] x [sizeY]) with [Semantics] in place.
  final IconData? icon;

  /// 🧮 Size in logical pixels to provide as space
  /// for this `IconToo` in one axis. May be `null`.
  /// Private field may be set during construction by `sizeX` / `sizeY`.
  ///
  /// See [sizeX] and [sizeY].
  final double? _sizeX, _sizeY;

  /// 🎨 [Color] with which to draw this [icon] glyph.
  ///
  /// This [IconToo] will default its [color] according to [IconTheme.of].
  final Color? color;

  /// 👥 This [IconToo] may have `shadows` rendered underneath
  /// like [TextStyle].
  ///
  /// Accepts `List<Shadow>`. See [Shadow] for more information.
  final List<Shadow>? shadows;

  /// 🔛 This [IconToo]  will side-align its glyph
  /// according to ambient or assigned [textDirection].
  ///
  /// Considering it is also [trueSize]d by design, default should be
  /// a desirable result, but override this value if necessary.
  ///
  /// A standard [Icon] centers its [IconData] glyph in a square [SizedBox],
  /// which is the root issue for non-square [icon]s.
  final AlignmentGeometry? alignment;

  /// 💬 This label is *announced* with accessibility modes active
  /// (such as TalkBack or VoiceOver) but *not shown* in the UI.
  ///
  ///  * Ultimately this `IconToo` is wrapped in a [Semantics].
  ///  * That [SemanticsProperties.label] is given [semanticLabel], if initialized.
  final String? semanticLabel;

  /// 🔚 The text direction to use when rendering this [IconToo].
  ///
  /// This property has no effect if the [icon]'s [IconData.matchTextDirection]
  /// field is `false`, but an [IconToo] must always specify a text direction
  /// for coherence with the specification:
  /// * either directly via [textDirection] initialization
  /// * or, if `null`, deafulting to [Directionality.of].
  final TextDirection? textDirection;

  /// 🧮 Horizontal size, or width, in logical pixels
  /// to provide as space for this `IconToo`.
  /// Gets [_sizeX] if assigned. May be `null`.
  ///
  /// ~~Will consider [_trueSize] prior to [_sizeX], but is deprecated.~~
  ///
  /// Unlike an [Icon.size] this `double` only represents
  /// the resolution of in one axis, `X`.
  ///
  /// Rendered [IconToo] defaults to the current [IconTheme.of] size,
  /// if any, itself defaulting to `24.0`.
  double? get sizeX => _trueSize?.width ?? _sizeX;

  /// 🧮 Vertical size, or height, in logical pixels
  /// to provide as space for this `IconToo`.
  /// Gets [_sizeY] if assigned. May be `null`.
  ///
  /// ~~Will consider [_trueSize] prior to [_sizeX], but is deprecated.~~
  ///
  /// Unlike an [Icon.size] this `double` only represents
  /// the resolution of in one axis, `Y`.
  ///
  /// Rendered [IconToo] defaults to the current [IconTheme.of] size,
  /// if any, itself defaulting to `24.0`.
  double? get sizeY => _trueSize?.height ?? _sizeY;

  /// 🧮 Returns this [IconToo]'s size as a [Size] with
  /// width equal to [sizeX], or `0.0` if `null`,
  /// and height equal to [sizeY], or `0.0` if `null`.
  ///
  /// [Size] objects have a few handy getters and methods.
  Size get asSize => Size(sizeX ?? 0.0, sizeY ?? 0.0);

  /// 👷‍♂️ Method responsible for laying-out and rendering an [IconToo],
  /// unique from an [Icon] in that [icon] may be non-square and [shadows]
  /// parameter is accepted.
  @override
  Widget build(BuildContext context) {
    assert(_trueSize == null || !(_trueSize!.isEmpty));
    assert(this.textDirection != null || debugCheckHasDirectionality(context));
    final TextDirection iconDirection =
        textDirection ?? Directionality.of(context);
    final IconThemeData iconTheme = IconTheme.of(context);

    final double iconWidth = sizeX ?? iconTheme.size!;
    final double iconHeight = sizeY ?? iconTheme.size!;
    final double fontSize = min(iconWidth, iconHeight); // shortest side

    // A standard Icon uses its `size` field for
    // both width and height. Even without IconData, an IconToo
    // still ought to consider "true size" for Semantics and spacing.
    if (icon == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconWidth, height: iconHeight),
      );
    }

    // Checked `icon == null` before continuing with any other computation.
    final double? iconThemeOpacity = iconTheme.opacity;
    Color? iconColor = color ?? iconTheme.color;
    if (iconThemeOpacity != 1.0)
      iconColor = iconColor!.withOpacity(iconColor.opacity * iconThemeOpacity!);

    // In the context of Icons, IconButtons, and IconData,
    // the "icon" itself is a character code for a specific font.
    Widget iconGlyph = RichText(
      overflow: TextOverflow.visible, // Though `trueSize`d, could be bad values
      textDirection: iconDirection,
      text: TextSpan(
        text: String.fromCharCode(icon!.codePoint),
        style: TextStyle(
          inherit: false,
          package: icon!.fontPackage,
          fontFamily: icon!.fontFamily,
          fontSize: fontSize,
          color: iconColor,
          shadows: shadows, // optional 👥 List<Shadow>
        ),
      ),
    );

    // Wrap iconGlyph in a Transform and flip if the IconData thus dictates.
    // Hover over / see: `matchTextDirection`.
    if (icon!.matchTextDirection) {
      switch (iconDirection) {
        case TextDirection.rtl:
          // Mirrors over Y-axis
          iconGlyph = Transform(
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0), // scales X
            alignment: Alignment.center,
            transformHitTests: false,
            child: iconGlyph,
          );
          break;
        case TextDirection.ltr:
          break;
      }
    }

    // TrueSized by design, this IconToo will side-align considering TextDirection.
    // A standard Icon center-aligns, which is the issue for non-square IconData.
    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          width: iconWidth,
          height: iconHeight,
          child: Align(
            alignment: alignment ??
                (iconDirection == TextDirection.rtl
                    ? Alignment.centerRight
                    : Alignment.centerLeft),
            child: iconGlyph,
          ),
        ),
      ),
    );
  }

  ///👨‍💻 Add `width` and `height` to existing [Icon] props.
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('width', sizeX, defaultValue: null));
    properties.add(DoubleProperty('height', sizeY, defaultValue: null));
  }

  // ____________________________
  // ## 🗜️ IconToo Utilities
  // - 📋 copyWith(. . .) ➡ IconToo
  // - 👆 operator >(VoidCallback onTap) ➡ IconButton
  // - ➕ operator +(inflate) ➡ sizer
  // - ➖ operator -(deflate) ➡ sizer
  // - ❌ operator *(dynamic operation) ➡ colorizer/sizer
  // - 💥 operator %(dynamic modulation) ➡ randomizer
  // - 🧦 operator &(dynamic padding) ➡ Padding
  // ____________________________

  /// 📋 Return an [IconToo] with fields that mirror `this`
  /// except for the parameters given with this method.
  ///
  /// Follows same pattern as [IconToo] in that a [Size] provided
  /// [trueSize] will override `num`s [sizeX] and [sizeY].
  IconToo copyWith({
    Key? key,
    IconData? icon,
    Size? trueSize,
    double? sizeX,
    double? sizeY,
    Color? color,
    List<Shadow>? shadows,
    AlignmentGeometry? alignment,
    String? semanticLabel,
    TextDirection? textDirection,
  }) =>
      IconToo(
        icon ?? this.icon,
        key: key ?? this.key, // should ignore this.key?
        sizeX: trueSize?.width ?? sizeX ?? this.sizeX,
        sizeY: trueSize?.height ?? sizeY ?? this.sizeY,
        color: color ?? this.color,
        shadows: shadows ?? this.shadows,
        alignment: alignment ?? this.alignment,
        semanticLabel: semanticLabel ?? this.semanticLabel,
        textDirection: textDirection ?? this.textDirection,
      );

  /// ## ➕ "Add" to this [IconToo] (size)
  ///     IconToo operator +(dynamic inflation)
  /// Returns `this` [IconToo] if [operation] does not match a case
  /// described below, otherwise [copyWith] size incremented by [inflation].
  ///
  /// ➕ `operator +(dynamic` [inflation]`)`
  /// - ❓ [inflation] `is` [num] ➡ `sizeX += inflation` & `sizeY += inflation`
  /// - ❓ [inflation] `is List<num>` (length==2) ➡ `sizeX += inflation[0]` & `sizeY += inflation[1]`
  IconToo operator +(dynamic inflation) => (inflation is num)
      ? copyWith(
          sizeX: (sizeX ?? 0.0) + inflation, sizeY: (sizeY ?? 0.0) + inflation)
      : (inflation is List<num>)
          ? (inflation.length == 2)
              ? copyWith(
                  sizeX: (sizeX ?? 0.0) + inflation[0],
                  sizeY: (sizeY ?? 0.0) + inflation[1],
                )
              : this
          : this;

  /// ## ➖ "Subtract" from this [IconToo] (size)
  ///     IconToo operator -(dynamic inflation)
  /// Returns `this` [IconToo] if [operation] does not match a case
  /// described below, otherwise [copyWith] size decremented by [deflation].
  ///
  /// ➖ `operator -(dynamic` [deflation]`)`
  /// - ❓ [deflation] `is` [num] ➡ `sizeX -= deflation` & `sizeY -= deflation`
  /// - ❓ [deflation] `is List<num>` (length==2) ➡ `sizeX -= deflation[0]` & `sizeY -= deflation[1]`
  IconToo operator -(dynamic deflation) => (deflation is num)
      ? copyWith(
          sizeX: (sizeX ?? 0.0) - deflation, sizeY: (sizeY ?? 0.0) - deflation)
      : (deflation is List<num>)
          ? (deflation.length == 2)
              ? copyWith(
                  sizeX: (sizeX ?? 0.0) - deflation[0],
                  sizeY: (sizeY ?? 0.0) - deflation[1],
                )
              : this
          : this;

  /// ## ❌ "Multiply" this [IconToo] (color/size)
  ///     IconToo operator *(dynamic operation)
  /// Returns `this` [IconToo] if [operation] does not match a case described below.
  ///
  /// ❌ `operator *(dynamic` [operation]`)`
  /// - ❓ [operation] `is` [Color] ➡ `color = operation`
  /// - ❓ [operation] `is` [num] ➡ `sizeX *= operation` & `sizeY *= operation`
  /// - ❓ [operation] `is List<num>` (length==2) ➡ `sizeX *= operation[0]` & `sizeY *= operation[1]`
  IconToo operator *(dynamic operation) => (operation is Color)
      ? copyWith(color: operation)
      : (operation is num)
          ? copyWith(
              sizeX: (sizeX ?? 0.0) * operation,
              sizeY: (sizeY ?? 0.0) * operation)
          : (operation is List<num>)
              ? (operation.length == 2)
                  ? copyWith(
                      sizeX: (sizeX ?? 0.0) * operation[0],
                      sizeY: (sizeY ?? 0.0) * operation[1],
                    )
                  : this
              : this;

  /// ## 💥 "Modulate" this [IconToo] (randomizer)
  ///     IconToo operator %(dynamic modulation)
  /// Returns `this` [IconToo] if [modulation] does not match a case described below.
  ///
  /// 💥 `operator *(dynamic` [modulation]`)`
  /// - ❓ [modulation] `is List<Color>` ➡ `color = modulation[Random()]`
  /// - ❓ [modulation] `is List<num>` ➡ `sizeX *= modulation[random]` & `sizeY *= modulation[random]`
  IconToo operator %(dynamic modulation) {
    if (!(modulation is List) || modulation.isEmpty) return this;
    final random = Random().nextInt(modulation.length);

    return (modulation is List<Color>)
        ? copyWith(color: modulation[random])
        : (modulation is List<num>)
            ? copyWith(
                sizeX: (sizeX ?? 0.0) * modulation[random],
                sizeY: (sizeY ?? 0.0) * modulation[random],
              )
            : this;
  }

  /// ## 🧦 "And" this [IconToo] (`Padding`)
  ///     IconToo operator &(dynamic padding)
  /// Returns `this` [IconToo] if [padding] does not match a case described below.
  ///
  /// 🧦 `operator &(dynamic` [padding]`)`
  /// - ❓ [padding] `is num` ➡ `EdgeInsets.all(padding)`
  /// - ❓ [padding] `is List<num>` (length==2) ➡ `EdgeInsets.symmetric(horizontal: padding[0], vertical: padding[1])`
  /// - ❓ [padding] `is List<num>` (length==4) ➡ `EdgeInsets.fromLTRB(padding[0], padding[1],padding[2], padding[3])`
  Widget operator &(dynamic padding) => (padding is num)
      ? Padding(
          padding: EdgeInsets.all(padding > 0 ? padding * 1.0 : 0), child: this)
      : (padding is List<num>)
          ? (padding.length == 2)
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: padding[0] > 0 ? padding[0] * 1.0 : 0,
                      vertical: padding[0] > 0 ? padding[0] * 1.0 : 0),
                  child: this,
                )
              : (padding.length == 4)
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(
                          padding[0] > 0 ? padding[0] * 1.0 : 0,
                          padding[1] > 0 ? padding[1] * 1.0 : 0,
                          padding[2] > 0 ? padding[2] * 1.0 : 0,
                          padding[3] > 0 ? padding[3] * 1.0 : 0),
                      child: this,
                    )
                  : this
          : this;

  /// ## 👆 "Chevron" this [IconToo] (`IconButton`)
  ///     IconToo operator >(VoidCallback onTap)
  /// Returns `this` [IconToo] wrapped in an [IconButton]
  /// with [asSize] `longestSide` for [IconButton.iconSize].
  /// Color is forwarded as well.
  ///
  /// Parameter following the `greater-than` symbol is a [Function]
  /// of type [VoidCallback].
  ///
  /// ```dart
  /// final IconToo icon = IconToo(Icons.arrow_back, sizeX: 40, sizeY: 40);
  /// // Whoa! `operator >(onTap)` method 😏
  /// final IconButton button = baseIcon * Colors.red > () => setState(() {});
  /// ```
  IconButton operator >(VoidCallback onTap) => IconButton(
        icon: this,
        iconSize: asSize.longestSide,
        color: color,
        onPressed: onTap,
      );

  /// 🧮 True size to provide as space for the glyph in logical pixels.
  /// May be `null`. Private field may be set during construction by `trueSize`.
  ///
  /// See [sizeX] and [sizeY].
  // @Deprecated(_DEPRECATED)
  final Size? _trueSize;
}

const _DEPRECATED =
    '`Size` dimensions not usable in const constructor. Migrate to doubles `sizeX` & `sizeY`. Gives `IconToo` objects source-of-truth for `Icon.size`: assigned `_sizeX ?? _sizeY`';
