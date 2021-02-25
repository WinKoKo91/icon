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
/// ---
///     IconToo(IconData icon, {@required Size trueSize, Color color})
/// Builds an [Icon] set inside a [SizedBox] constrained by [trueSize],
/// with given data [icon] and optionally passing [color].
///
/// ✨ As a bonus, [IconToo] supports the `shadows` parameter from [TextStyle],
/// passed as `List<Shadow>` and rendered under an [IconToo].
///
/// See [Shadow] for more information.
///
/// ### Example usage with an [IconButton]:
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
class IconToo extends Icon {
  const IconToo(this.icon, {@required this.trueSize, this.color, this.shadows})
      : super(icon);

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

  /// 👷‍♂️ Method responsible for laying-out and rendering an [IconToo],
  /// unique from an [Icon] in that the [IconData] may be non-square.
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double iconThemeOpacity = iconTheme.opacity;
    Color iconColor = color ?? iconTheme.color;
    if (iconThemeOpacity != 1.0)
      iconColor = iconColor.withOpacity(iconColor.opacity * iconThemeOpacity);

    final double iconWidth = trueSize?.width ?? (iconTheme.size);
    final double iconHeight = trueSize?.height ?? (iconTheme.size);
    // 🧮 The minimum of iconWidth and iconHeight to use as
    // fontSize parameter in [RichText].
    final double fontSize = min(iconWidth, iconHeight);

    Widget iconWidget = RichText(
      overflow: TextOverflow.visible, // Not that we plan to clip anyway.
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          inherit: false,
          color: iconColor,
          fontSize: fontSize,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          shadows: shadows ?? [], // ✨ Bonus List<Shadow> pass!
        ),
      ),
    );

    // A standard [Icon] uses its [Icon.size] parameter for
    // both width and height. Even without IconData, an [IconToo]
    // still ought to consider that a [Size] may have been initialized.
    if (icon == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconWidth, height: iconHeight),
      );
    }

    // Just as in [Icon], construct a SizedBox but Align the glyph
    // centerLeft instead of Center.
    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          width: iconWidth,
          height: iconHeight,
          child: Align(
            alignment: Alignment.centerLeft,
            child: iconWidget,
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
    properties.add(DoubleProperty('width', trueSize.width, defaultValue: null));
    properties
        .add(DoubleProperty('height', trueSize.height, defaultValue: null));
    properties.add(ColorProperty('color', color, defaultValue: null));
  }
}
