/// ## Icon Utilities
/// - 📋 `copyWith`
/// - ❌ `operator *(dynamic operation)`
///   - `operation is Color` => this.copyWith(color:operation)
///   - `operation is double` => this.copyWith(size ?? 0 * operation)
/// - ➕ `operator +(double inflate)`
/// - ➖ `operator -(double deflate)`
library icon;

import 'package:flutter/widgets.dart';

extension IconUtils on Icon {
  Icon copyWith(
          {Key? key,
          IconData? icon,
          double? size,
          Color? color,
          String? semanticLabel,
          TextDirection? textDirection}) =>
      Icon(
        icon ?? this.icon,
        key: key ?? this.key,
        size: size ?? this.size,
        color: color ?? this.color,
        semanticLabel: semanticLabel ?? this.semanticLabel,
        textDirection: textDirection ?? this.textDirection,
      );

  /// ## ❌ "Multiply" an [Icon]
  ///     Icon operator *(dynamic operation)
  /// Returns `this` [Icon] if [operation] does not properly match a case.
  ///
  /// - If [operation] `is` [Color] `=> this.copyWith(color: operation)`
  /// - If [operation] `is` [double] `=> this.copyWith(size: size ?? 0 * operation)`
  Icon operator *(dynamic operation) => (operation is Color)
      ? this.copyWith(color: operation)
      : (operation is double)
          ? this.copyWith(size: size ?? 0 * operation)
          : this;

  /// ## ➕ "Add" to [Icon]
  ///     Icon operator +(double inflation)
  /// Returns `this` [Icon] but [copyWith] an [icon.size] incremented by [inflation].
  Icon operator +(double inflation) =>
      this.copyWith(size: size ?? 0 + inflation);

  /// ## ➖ "Subtract" from [Icon]
  ///     Icon operator -(double deflation)
  /// Returns `this` [Icon] but [copyWith] an [icon.size] decremented by [deflation].
  Icon operator -(double deflation) =>
      this.copyWith(size: size ?? 0 + deflation);
}
