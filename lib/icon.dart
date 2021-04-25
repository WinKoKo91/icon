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
/// ### Icon Utilities
/// - 📋 `copyWith`
/// - ❌ `operator *(dynamic operation)`
///   - `operation is Color => this.copyWith(color:operation)`
///   - `operation is double => this.copyWith(size: size ?? 0 * operation)`
/// - ➕ `operator +(double inflate)`
/// - ➖ `operator -(double deflate)`
library icon;

export 'src/icon_too.dart';
export 'src/utils.dart';
