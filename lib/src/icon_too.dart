/// ## 🙋‍♂️ I'm an Icon Too!
/// #### An extended Icon for those that are not actually square.
///
/// ... because Flutter's native [Icon] ["assumes that the rendered icon is squared."](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24)
library icon_too;

import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// ## 🙋‍♂️ I'm an [IconToo]!
/// #### An extended Icon for those that are not actually square.
///
/// ... because Flutter's native [Icon] ["assumes that the rendered icon is squared."](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24)
///
/// > ***NOTE:***
/// > *As a new Dart developer, I am unsure if reimplementing*
/// > *the functionality of built-in [Icon] within [IconToo] is even*
/// > *proper practice for a class such as this that extends base [Icon].*
/// >
/// > *That said, all the boxes are checked as far as the parameters*
/// > *that a standard [Icon] looks for and the accesibility & debug*
/// > *features they offer.*
class IconToo extends Icon {
  /// ## 🙋‍♂️ I'm an Icon Too!
  /// #### An extended Icon for those that are not actually square. Plus shadows support!
  ///
  /// ... because Flutter's native [Icon] ["assumes that the rendered icon is squared."](https://github.com/flutter/flutter/blob/f2a25c5bd2de39a80246370ad53c5bf2e93c81be/packages/flutter/lib/src/widgets/icon.dart#L24)
  ///
  /// ---
  ///     IconToo(icon, {trueSize, color, shadows, textDirection, semanticLabel})
  /// Builds an [Icon]-akin widget set inside a [SizedBox] constrained by [trueSize],
  /// with given [icon] data and optionally passing [color] or [shadows].
  ///
  /// ✨ As a bonus, [IconToo] supports the `shadows` parameter from [TextStyle],
  /// passed as `List<Shadow>` and rendered under an [IconToo].
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
  ///     // IconToo passes `fontSize = min(trueSize.width, trueSize.height)` to `TextStyle()`
  ///     trueSize: Size(34.0 * 5, 34.0),
  ///   ),
  ///   // But we need the max() to ensure an IconButton has a diameter that encompasses the entire IconToo
  ///   iconSize: 34.0 * 5,
  ///   onPressed: () {},
  /// );
  /// ```
  /// An [IconToo] may still have undesirable results if placed in a
  /// [GestureDetector] instead of following the idea above with an [IconButton].
  const IconToo(
    this.icon, {
    Key key,
    this.trueSize,
    this.color,
    this.shadows,
    this.textDirection,
    this.semanticLabel,
  }) : super(icon, key: key);

  /// #### 🆔 The icon data to display.
  ///
  /// Available Material icons are described in [Icons], but none found
  /// there are non-square. Only custom icons, such as [CustomIcons]
  /// found in the IconToo Example app, would contain non-square [IconData].
  ///
  /// The icon can be null, in which case the widget will render as an empty
  /// space of the specified [trueSize] with [Semantics] in place.
  final IconData icon;

  /// #### 🧮 The true size to provide as space for the glyph in logical pixels.
  ///
  /// [IconToo]s occupy a rectangle with width and height equal to [Size] values
  /// [trueSize.width] and [trueSize.height].
  ///
  /// Defaults to the current [IconTheme] size, if any. If there is no
  /// [IconTheme], or it does not specify an explicit size,
  /// then it defaults to 24.0.
  final Size trueSize;

  /// #### 🎨 [Color] with which to render the [IconToo].
  final Color color;

  /// ✨ As a bonus, [IconToo] supports the `shadows`
  /// parameter from [TextStyle].
  ///
  /// #### Passed as `List<Shadow>` and rendered under an [IconToo].
  /// See [Shadow] for more information.
  final List<Shadow> shadows;

  /// 💬 This label is *announced* with accessibility modes active
  /// (such as TalkBack or VoiceOver) but not shown in the UI.
  ///
  ///  * Ultimately each IconToo returns a [Semantics].
  ///  * That [SemanticsProperties.label] is passed [semanticLabel] if initialized
  final String semanticLabel;

  /// ↔ The text direction to use when rendering this IconToo.
  ///
  /// This property has no effect if the [icon]'s [IconData.matchTextDirection]
  /// field is `false`, but an IconToo must always specify a text direction
  /// for coherence with the specification:
  /// * either directly via [textDirection] initialization
  /// * or, if `null`, deafulting to [Directionality].
  final TextDirection textDirection;

  /// 👷‍♂️ Method responsible for laying-out and rendering an [IconToo],
  /// unique from an [Icon] in that the [IconData] may be non-square.
  @override
  Widget build(BuildContext context) {
    assert(this.textDirection != null || debugCheckHasDirectionality(context));
    final TextDirection iconDirection =
        textDirection ?? Directionality.of(context);
    final IconThemeData iconTheme = IconTheme.of(context);

    final double iconWidth = trueSize?.width ?? (iconTheme.size);
    final double iconHeight = trueSize?.height ?? (iconTheme.size);
    // 🧮 The minimum of iconWidth and iconHeight to use as
    // fontSize parameter in [RichText].
    final double fontSize = min(iconWidth, iconHeight);

    // A standard [Icon] uses its [Icon.size] parameter for
    // both width and height. Even without IconData, an [IconToo]
    // still ought to consider that a [trueSize] may have been initialized
    // for the Semantics.
    if (icon == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconWidth, height: iconHeight),
      );
    }

    // That null check also occurs before potentially computing
    // any color or opacity values.
    final double iconThemeOpacity = iconTheme.opacity;
    Color iconColor = color ?? iconTheme.color;
    if (iconThemeOpacity != 1.0)
      iconColor = iconColor.withOpacity(iconColor.opacity * iconThemeOpacity);

    // As true with standard Icons, the central heart of the
    // widget is a glyph from a font rendered in a RichText.
    Widget iconGlyph = RichText(
      overflow: TextOverflow.visible, // Not that we plan to clip anyway.
      textDirection: iconDirection,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          inherit: false,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: fontSize,
          color: iconColor,
          shadows: shadows ?? [], // ✨ Bonus List<Shadow> pass!
        ),
      ),
    );

    // The central RichText may be replaced,
    // so [iconGlyph] returns type Widget.
    if (icon.matchTextDirection) {
      switch (iconDirection) {
        case TextDirection.rtl:
          iconGlyph = Transform(
            transform: Matrix4.identity()
              ..scale(-1.0, 1.0, 1.0), // Mirrors over Y-axis
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
            alignment: Alignment.centerLeft,
            child: iconGlyph,
          ),
        ),
      ),
    );
  }

  /// 👨‍💻 Following the pattern established in Flutter's [Icon]
  /// but with 'width' and 'height' [DoubleProperty]s instead of 'size'.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        IconDataProperty('icon', icon, ifNull: '<empty>', showName: false));
    properties
        .add(DoubleProperty('width', trueSize?.width, defaultValue: null));
    properties
        .add(DoubleProperty('height', trueSize?.height, defaultValue: null));
    properties.add(ColorProperty('color', color, defaultValue: null));
  }
}
