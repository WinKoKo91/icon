/// ## 🗜️ Icon Utilities
/// - 📋 `copyWith`
/// - 👆 "Chevron" `Icon > (VoidCallback onTap)` ➡ [IconButton]
/// - ➕ `add`
/// - ➖ `subtract`
/// - ❌ `multiply`
///   - ❓ `operation is Color`
///   - ❓ `operation is num`
/// - 💥 `modulate`
///   - ❓ `modulation is List<Color>`
///   - ❓ `modulation is List<num>`
library icon;

import 'dart:math' show Random;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show IconButton;

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
extension IconUtils on Icon {
  /// 📋 Return an [Icon] with fields that mirror `this`
  /// except for the parameters given with this method.
  Icon copyWith({
    Key? key,
    IconData? icon,
    double? size,
    Color? color,
    String? semanticLabel,
    TextDirection? textDirection,
  }) =>
      Icon(
        icon ?? this.icon,
        key: key ?? this.key, // should ignore this.key?
        size: size ?? this.size,
        color: color ?? this.color,
        semanticLabel: semanticLabel ?? this.semanticLabel,
        textDirection: textDirection ?? this.textDirection,
      );

  /// ## ➕ "Add" to [Icon]
  ///     Icon operator +(num inflation)
  /// Returns `this` [Icon] but [copyWith] an [icon.size] incremented by [inflation].
  ///
  /// ➕ ➡ `size += inflation`
  Icon operator +(num inflation) => copyWith(size: (size ?? 0) + inflation);

  /// ## ➖ "Subtract" from [Icon]
  ///     Icon operator -(num deflation)
  /// Returns `this` [Icon] but [copyWith] an [icon.size] decremented by [deflation].
  ///
  /// ➖ ➡ `size -= deflation`
  Icon operator -(num deflation) => copyWith(size: (size ?? 0) + deflation);

  /// ## ❌ "Multiply" an [Icon]
  ///     Icon operator *(dynamic operation)
  /// Returns `this` [Icon] if [operation] does not match a case described below.
  ///
  /// - ❌ `operator *(dynamic operation)`
  ///   - ❓ [operation] `is` [Color] `=> this.copyWith(color = operation)`
  ///   - ❓ [operation] `is` [num] `=> this.copyWith(size *= * operation)`
  Icon operator *(dynamic operation) => (operation is Color)
      ? copyWith(color: operation)
      : (operation is num)
          ? copyWith(size: (size ?? 0) * operation)
          : this;

  /// ## 💥 "Modulate" this [Icon] Randomly
  ///     Icon operator %(dynamic modulation)
  /// Returns `this` [Icon] if [modulation] does not match a case described below.
  ///
  /// 💥 `operator *(dynamic` [modulation]`)`
  /// - ❓ [modulation] `is List<Color>` ➡ `color = modulation[Random()]`
  /// - ❓ [modulation] `is List<num>` ➡ `size *= modulation[Random()]`
  Icon operator %(dynamic modulation) =>
      (!(modulation is List) || modulation.isEmpty)
          ? this
          : (modulation is List<Color>)
              ? copyWith(color: modulation[Random().nextInt(modulation.length)])
              : (modulation is List<num>)
                  ? copyWith(
                      size: (size ?? 0.0) *
                          modulation[Random().nextInt(modulation.length)],
                    )
                  : this;

  /// ## 🧦 "And" this [Icon]
  ///     Icon operator &(dynamic padding)
  /// Returns `this` [Icon] if [padding] does not match a case described below.
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

  /// ## 👆 "Chevron" this [Icon]
  ///     Icon operator >(VoidCallback onTap)
  /// Returns `this` [Icon] wrapped in an [IconButton]
  /// with [size] for [IconButton.iconSize].
  /// Color is forwarded as well.
  ///
  /// Parameter following the `greater-than` symbol is a [Function]
  /// of type [VoidCallback].
  ///
  /// ```dart
  /// final Icon icon = Icon(Icons.arrow_back, size: 40);
  /// // Whoa! `operator >(onTap)` method 😏
  /// final IconButton button = icon * Colors.red > () => setState(() {});
  /// ```
  IconButton operator >(VoidCallback onTap) => IconButton(
        icon: this,
        iconSize: size ?? 24.0,
        color: color,
        onPressed: onTap,
      );
}
