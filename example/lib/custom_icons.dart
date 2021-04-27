/// The IconData of our focus for this example is
/// ```
/// CustomIcons.logo_bugbash
/// ```
/// and it is *not* a square glyph, so a regular [Icon] will render it incorrectly.
/// - It is not provided proper horizontal space nor aligned correctly.
///
/// [CustomIcons.logo_bugbash] is four times wider than it is tall.
/// - In a font editor, one would see the width of the glyph is `4000`
/// while others typically have a width of `~1000`.
library icon_example;

import 'dart:ui' show Shadow, Offset;
import 'package:flutter/widgets.dart' show Icon, IconData;

/// The IconData used in this example, [CustomIcons.logo_bugbash],
/// is four times wider than it is tall.
///
/// In a font editor, one would see the width of the glyph is `4000`
/// while others typically have a width of `~1000`.
const ICON_WIDTH_RATIO = 4.0;

/// Constant for UI styling.
const SHADOWS = [Shadow(offset: Offset(0, 1))];

/// The IconData of our focus for this example is
/// ```
/// CustomIcons.logo_bugbash
/// ```
/// and it is *not* a square glyph, so a regular [Icon] will render it incorrectly.
/// - It is not provided proper horizontal space nor aligned correctly.
///
/// [CustomIcons.logo_bugbash] is four times wider than it is tall.
/// - In a font editor, one would see the width of the glyph is `4000`
/// while others typically have a width of `~1000`.
class CustomIcons {
  /// The IconData of our focus for this example is
  /// ```
  /// CustomIcons.logo_bugbash
  /// ```
  /// and it is *not* a square glyph, so a regular [Icon] will render it incorrectly.
  /// - It is not provided proper horizontal space nor aligned correctly.
  ///
  /// [CustomIcons.logo_bugbash] is four times wider than it is tall.
  /// - In a font editor, one would see the width of the glyph is `4000`
  /// while others typically have a width of `~1000`.
  static const IconData logo_bugbash =
      IconData(0x007E, fontFamily: 'BashinBugs-Stripped');
}
