/// ## 🙋‍♂️ I'm an Icon Too!
/// An extended Icon for those that are not actually square
/// --because Flutter's native [Icon] ["assumes that the rendered icon is squared."](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24)
///
/// * Support for `List<Shadow>` as `IconToo.shadows` is available.
/// * Support for `AlignmentGeometry` as `IconToo.alignment` is available.
///   - But defaults to `Directionality.of` because it is `trueSize`d by design
///
/// ! Note that parameter `IconToo.trueSize` is a `Size` and not a `double`.
/// - `sizeX` and `sizeY` are available for `const` construction with doubles
///   - But not forwarded to [Icon]
library icon;

import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// ## 🙋‍♂️ I'm an Icon Too!
/// An extended Icon for those that are not actually square
/// --because Flutter's native [Icon] ["assumes that the rendered icon is squared."](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24)
///
/// * Support for `List<Shadow>` as `IconToo.shadows` is available.
/// * Support for `AlignmentGeometry` as `IconToo.alignment` is available.
///   - But defaults to `Directionality.of` because it is `trueSize`d by design
///
/// ! Note that parameter `IconToo.trueSize` is a `Size` and not a `double`.
/// - `sizeX` and `sizeY` are available for `const` construction with doubles
///   - But not forwarded to [Icon]
///
/// > ***NOTE:***
/// > *All the boxes are checked as far as the parameters for which a*
/// > *standard [Icon] looks and the accessibility & debug features they offer.*
class IconToo extends Icon {
  /// ## 🙋‍♂️ I'm an Icon Too!
  /// #### An extended Icon for those that are not actually square. Plus shadows support!
  ///
  /// ... because Flutter's native [Icon] ["assumes that the rendered icon is squared."](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24)
  ///
  /// ---
  ///     IconToo(icon, {trueSize, color, shadows, textDirection, semanticLabel})
  /// Builds an [Icon]-akin widget set inside a [SizedBox] constrained by [trueSize],
  /// with given [icon] data and optionally accepting [color] or [shadows].
  ///
  /// ✨ As a bonus, [IconToo] supports the `shadows` parameter thanks to
  ///    [TextStyle], accepted as `List<Shadow>` and rendered under an [IconToo].
  ///
  /// See [Shadow] for more information.
  ///
  /// #### Replete with proper [`Semantics`](https://api.flutter.dev/flutter/widgets/Semantics-class.html 'Flutter API: Semantics') and [debug `Property`s](https://api.flutter.dev/flutter/foundation/DoubleProperty-class.html 'Flutter API: DoubleProperty').
  /// ---
  ///
  /// ### ❓ Example usage with an [IconButton]:
  /// ```dart
  /// IconButton(
  ///   icon: IconToo(
  ///     color: Colors.red,
  ///     CustomIcons.non_square_icon,
  ///     // IconToo passes `fontSize = min(trueSize.width, trueSize.height)`
  ///     // to glyph-rendering TextStyle:
  ///     trueSize: Size(34.0 * 5, 34.0),
  ///   ),
  ///   // But we need the max() to ensure an IconButton has a diameter
  ///   // that encompasses the entire IconToo:
  ///   iconSize: 34.0 * 5,
  ///   onPressed: () {},
  /// );
  /// ```
  const IconToo(
    this.icon, {
    Key? key,
    this.trueSize,
    this.sizeX,
    this.sizeY,
    this.color,
    this.shadows,
    this.alignment,
    this.semanticLabel,
    this.textDirection,
  }) : super(
          icon,
          key: key,
          color: color,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );

  /// #### 🆔 The icon data to display.
  ///
  /// Available Material icons are described in [Icons], but none found
  /// there are non-square. Only custom icons, such as [CustomIcons] from
  /// [custom_icons.dart] found in the IconToo Example app,
  /// would contain non-square [IconData].
  ///
  /// The icon ***may*** be `null`, in which case the widget will render as an empty
  /// space of the specified [trueSize] with [Semantics] in place.
  final IconData? icon;

  /// #### 🧮 Size to provide as space for the glyph in logical pixels.
  /// Like an [Icon.size] but represents only the resolution of
  /// this [IconToo] in one axis, `X` or `Y`.
  ///
  /// Will be overridden if [trueSize] is assigned a `Size`.
  final double? sizeX, sizeY;

  /// #### 🧮 True size to provide as space for the glyph in logical pixels.
  ///
  /// [IconToo]s occupy a rectangle with width and height equal to [Size] values
  /// [trueSize.width] and [trueSize.height].
  ///
  /// Overrides any assigned [sizeX] or [sizeY].
  ///
  /// Defaults to the current [IconTheme] size, if any. If there is no
  /// [IconTheme], or it does not specify an explicit size,
  /// then it defaults to 24.0.
  final Size? trueSize;

  /// #### 🎨 [Color] with which to draw this [IconToo].
  final Color? color;

  /// ✨ As a bonus, [IconToo] supports the `shadows`
  /// parameter like [TextStyle],
  ///
  /// #### passed as `List<Shadow>` and rendered under an [IconToo].
  ///
  /// See [Shadow] for more information.
  final List<Shadow>? shadows;

  /// A standard [Icon] will [Center] its [IconData] glyph in a square [SizedBox].
  ///
  /// An [IconToo], by default, will [Alignment.centerLeft] if `LTR`
  /// or [Alignment.centerRight] if `RTL` its glyph in a [SizedBox] of:
  ///
  /// [trueSize] || [sizeX] x [sizeY] ||
  /// [IconTheme.of]`(Context).size!` x [IconTheme.of]`(Context).size!`
  final AlignmentGeometry? alignment;

  /// 💬 This label is *announced* with accessibility modes active
  /// (such as TalkBack or VoiceOver) but not shown in the UI.
  ///
  ///  * Ultimately each IconToo returns a [Semantics].
  ///  * That [SemanticsProperties.label] is passed [semanticLabel] if initialized
  final String? semanticLabel;

  /// ↔ The text direction to use when rendering this IconToo.
  ///
  /// This property has no effect if the [icon]'s [IconData.matchTextDirection]
  /// field is `false`, but an [IconToo] must always specify a text direction
  /// for coherence with the specification:
  /// * either directly via [textDirection] initialization
  /// * or, if `null`, deafulting to [Directionality.of].
  final TextDirection? textDirection;

  /// 👷‍♂️ Method responsible for laying-out and rendering an [IconToo],
  /// unique from an [Icon] in that the [IconData] may be non-square.
  @override
  Widget build(BuildContext context) {
    assert(this.textDirection != null || debugCheckHasDirectionality(context));
    final TextDirection iconDirection =
        textDirection ?? Directionality.of(context);
    final IconThemeData iconTheme = IconTheme.of(context);

    final double iconWidth = trueSize?.width ?? sizeX ?? iconTheme.size!;
    final double iconHeight = trueSize?.height ?? sizeY ?? iconTheme.size!;
    // 🧮 The minimum of iconWidth and iconHeight to use as
    // fontSize parameter in [RichText].
    final double fontSize = min(iconWidth, iconHeight);

    // A standard [Icon] uses its [Icon.size] parameter for
    // both width and height. Even without IconData, an [IconToo]
    // still ought to consider that a [trueSize] may have been initialized
    // for the Semantics and spacing.
    if (icon == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconWidth, height: iconHeight),
      );
    }

    // That `null` check also occurs before potentially computing
    // any color or opacity values.
    final double? iconThemeOpacity = iconTheme.opacity;
    Color? iconColor = color ?? iconTheme.color;
    if (iconThemeOpacity != 1.0)
      iconColor = iconColor!.withOpacity(iconColor.opacity * iconThemeOpacity!);

    // As true with standard Icons, the central heart of the
    // widget is a glyph from a font rendered in a RichText.
    Widget iconGlyph = RichText(
      overflow: TextOverflow.visible, // Not that we plan to clip anyway.
      textDirection: iconDirection,
      text: TextSpan(
        text: String.fromCharCode(icon!.codePoint),
        style: TextStyle(
          inherit: false,
          fontFamily: icon!.fontFamily,
          package: icon!.fontPackage,
          fontSize: fontSize,
          color: iconColor,
          shadows: shadows ?? [], // ✨ Bonus List<Shadow> pass!
        ),
      ),
    );

    // The central RichText may be replaced,
    // so [iconGlyph] returns type Widget.
    if (icon!.matchTextDirection) {
      switch (iconDirection) {
        case TextDirection.rtl:
          // Mirrors over Y-axis
          iconGlyph = Transform(
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
            alignment: Alignment.center,
            transformHitTests: false,
            child: iconGlyph,
          );
          break;
        case TextDirection.ltr:
          break;
      }
    }

    // Just as with an Icon, construct a SizedBox but Align the glyph
    // centerLeft instead of Center.
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

  ///👨‍💻 Following the pattern established in Flutter's [Icon]
  /// but with 'width' and 'height' [DoubleProperty]s instead of 'size'.
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        IconDataProperty('icon', icon, ifNull: '<empty>', showName: false));
    properties.add(
        DoubleProperty('width', trueSize?.width ?? sizeX, defaultValue: null));
    properties.add(DoubleProperty('height', trueSize?.height ?? sizeY,
        defaultValue: null));
    properties.add(ColorProperty('color', color, defaultValue: null));
  }
}
