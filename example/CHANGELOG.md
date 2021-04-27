# Icon Example
## **[2.2.0] - 27 APR 21**
- General code clean-up and added documentation aimed at new developers.
- Aimed at developers who are looking for some shortcuts, `Demo3` is in development to show off the new `Icon`/`Too` `operators`.

## **[2.0.0] - 05 APR 21**
- Null-safe Example app.

## **[1.0.0] - 25 FEB 21**
- Added [Demo 2](https://github.com/Zabadam/icon_too/blob/main/example/lib/main.dart#L114 'AppBar leading icon in Icon Example app'), accessible by the leading AppBar button.
  - Demonstrates IconToo in a series of Wrapped icons that would otherwise overlap.
- Gave the AppBar a TabBar whose sole Tab has an `icon` parameter initialized to an `IconToo`.
  - Demonstrates the Example application title's intention directly in the AppBar.
- Provided `shadows` for leading AppBar icon, which is now an IconToo.
  - `trueSize` is no longer a `@required` parameter, such that an IconToo may substitute a standard Icon.

## **[0.1.0] - 25 FEB 21**
- Initial release of Icon Example app demonstrates the usage of a non-square `IconToo` within a square `IconButton`.
  - Consider the `FloatingActionButton`s and the way they (do or do not) clip in the demo.
