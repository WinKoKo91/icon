import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:icon/icon.dart';
import 'custom_icons.dart';

/// Title for this example in the AppBar.
const _TITLE = 'Icon Example: Using an IconToo';

/// The non-square icon's presentation height
/// for this example, utilized in the FABs and TabBar.
const _ICON_SIZE = 20.0;

/// The IconData used in this example, [CustomIcons.logo_bugbash],
/// is four times wider than it is tall.
/// Literally, the width of the glyph is 4000 while others typically have a width of 1000.
const _ICON_WIDTH_RATIO = 4.0;

/// Some constants for basic UI styling.
const _ICON_OPEN = Icons.note_add_outlined;
const _ICON_CLOSE = Icons.cancel_outlined;
const _SHADOWS = [Shadow(offset: Offset(0, 1))];
const _DURATION = Duration(milliseconds: 500);
const _CURVE = Curves.fastOutSlowIn;

void main() {
  runApp(IconExample());
}

class IconExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: _TITLE,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red,
            backgroundColor: const Color(0xFF550000)),
      ).copyWith(
        textTheme: ThemeData(brightness: Brightness.dark).textTheme,
      ),
      home: Landing(),
    );
  }
}

class Landing extends StatefulWidget {
  Landing({Key key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> with TickerProviderStateMixin {
  double _width, _height;
  int _counter = 0;
  TextStyle _technical, _overline, _headline4, _headline1;

  /// The AppBar leading IconButton toggles the second demo.
  /// Initialize the IconData value for the button here.
  /// We will control other stateful UI elements with this value.
  IconData _demo2Icon = _ICON_OPEN;

  /// Because this is a sample app...
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Force portrait orientation.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    /// Store display resolution each time this [_LandingState] is built.
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    /// Shortcut some [TextStyle]s.
    _technical = Theme.of(context).textTheme.subtitle2.copyWith(
          fontFamily: 'serif',
          fontWeight: FontWeight.bold,
          shadows: _SHADOWS,
          fontSize: 10,
        );
    _overline = Theme.of(context).textTheme.overline.copyWith(
          shadows: _SHADOWS,
        );
    _headline4 = Theme.of(context).textTheme.headline4.copyWith(
          shadows: _SHADOWS,
          color: const Color(0xFFFFFFFF),
        );
    _headline1 = Theme.of(context).textTheme.headline1.copyWith(
          shadows: _SHADOWS,
          color: const Color(0xFFFFFFFF),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _TITLE,
          style: TextStyle(shadows: _SHADOWS),
        ),
        centerTitle: true,
        elevation: (_demo2Icon == _ICON_OPEN) ? 0 : 50,

        /// Tapping the AppBar leading button will toggle visibility of
        /// Demo 2, demonstrating how `IconToo`s will not overlap
        /// the way normal `Icon`s overlap.
        leading: IconButton(
          /// This IconToo with default params would be
          /// visually equivalent to a standard Icon, but
          /// elect to pass `shadows`.
          ///
          /// This is a neat little ✨ additional feature, as traditionally
          /// an icon shadow might be achieved with something like this:
          /// https://github.com/Zabadam/surface/blob/main/example/lib/main.dart#L290
          icon: IconToo(_demo2Icon, shadows: _SHADOWS),
          tooltip: 'Toggle Demo 2: Wrapping Icons',
          onPressed: () {
            if (_demo2Icon == _ICON_OPEN) {
              setState(() => _demo2Icon = _ICON_CLOSE);
            } else {
              setState(() => _demo2Icon = _ICON_OPEN);
            }
          },
        ),

        /// Scaffold TabBar
        bottom: TabBar(
          tabs: [
            Tab(
                icon: IconToo(
              CustomIcons.logo_bugbash,
              trueSize: Size(_ICON_SIZE * _ICON_WIDTH_RATIO, _ICON_SIZE),
              shadows: _SHADOWS,
            )),
          ],
          controller: TabController(vsync: this, length: 1),
        ),
      ),

      /// Scaffold Body
      body: Stack(children: [
        /// 🌆 Build Background
        buildBackground(),

        /// 👕 Build Body
        buildBody(),

        /// 2️⃣ Build Demo 2
        buildDemo2(),
      ]),

      /// Scaffold FAB(s)
      floatingActionButton: AnimatedOpacity(
        duration: _DURATION,
        curve: _CURVE,
        opacity: (_demo2Icon == _ICON_CLOSE) ? 0 : 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// 🔤
            exampleFAB(
              'Icon() 🔻\n IconButton()',
              _technical,

              /// 🔘
              child: exampleIconButton(
                icon: Icon(
                  CustomIcons.logo_bugbash,
                  size: _ICON_SIZE,
                  color: Colors.white,
                ),
                iconSize: _ICON_SIZE,
                tooltip:
                    'Typical experience with non-square Icons within IconButtons',
              ),
            ),

            /// 🔤
            exampleFAB(
              'Icon() 🔻\n ratio\'d IconButton()',
              _technical,

              /// 🔘
              child: exampleIconButton(
                icon: Icon(
                  CustomIcons.logo_bugbash,
                  size: _ICON_SIZE,
                  color: Colors.white,
                ),
                iconSize: _ICON_SIZE * _ICON_WIDTH_RATIO,
                tooltip:
                    'IconButton passed an iconSize larger than Icon, but problem persists',
              ),
            ),

            /// 🔤
            exampleFAB(
              'IconToo() 🔻\n ratio\'d IconButton()',
              _technical,

              /// 🔘
              child: exampleIconButton(
                icon: IconToo(
                  CustomIcons.logo_bugbash,
                  trueSize: Size(_ICON_SIZE * _ICON_WIDTH_RATIO, _ICON_SIZE),
                  color: Colors.white,

                  /// ✨ As a bonus, [IconToo] supports the `shadows` parameter
                  /// from [TextStyle].
                  shadows: _SHADOWS,
                ),
                iconSize: _ICON_SIZE * _ICON_WIDTH_RATIO,
                tooltip:
                    'IconToo extends Icon but provides a trueSize SizedBox',
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔘 Returns a partially-transparent black Container
  /// whose child is an [IconButton] with passed [icon] and
  /// [iconSize] that onPressed calls [_incrementCounter].
  Widget exampleIconButton(
      {@required Icon icon, @required double iconSize, String tooltip}) {
    return IgnorePointer(
      ignoring: (_demo2Icon == _ICON_CLOSE),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black38,
        ),
        child: IconButton(
          icon: icon,
          iconSize: iconSize,
          tooltip: tooltip ?? '',
          onPressed: _incrementCounter,
        ),
      ),
    );
  }

  /// 🔤 Returns a short Column requiring a String [label]
  /// styled by a required [textStyle]
  /// followed by a required but named [child].
  ///
  /// In the case of this example,
  /// the [child] pass will be an [exampleIconButton].
  Widget exampleFAB(String label, TextStyle textStyle,
      {@required Widget child}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
        child,
      ],
    );
  }

  /// 👕 Returns the content on the main page of this example application.
  Padding buildBody() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'A nice, basic counter example\n'.toUpperCase(),
                style: _overline,
                children: [
                  TextSpan(
                    text: 'Number of ',
                    style: _headline4,
                  ),
                  TextSpan(
                    text: '~',
                    style: _headline4
                        .merge(TextStyle(fontFamily: 'BashinBugs-Stripped')),
                  ),
                  TextSpan(text: '\nbutton presses:', style: _headline4),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 350),
              curve: Curves.easeInExpo,
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).primaryColor.withOpacity(0.25),
                backgroundBlendMode: BlendMode.difference,
              ),
              child: Text(
                  (_counter < 10)
                      ? '0' + _counter.toString()
                      : _counter.toString(),
                  style: _headline1),
            ),
            Spacer(),
            Flexible(
              child: Text(
                'const _ICON_SIZE = $_ICON_SIZE\nconst _ICON_WIDTH_RATIO = $_ICON_WIDTH_RATIO',
                style: _technical.copyWith(fontSize: 22),
              ),
            ),
            Flexible(
              child: Text(
                'The IconData used in this example, [CustomIcons.logo_bugbash], is four times wider than it is tall. Literally, the width of the glyph is 4000 while others typically have a width of 1000.',
                style: _overline.copyWith(
                    letterSpacing: 0.25,
                    fontSize: 14,
                    color: const Color(0xDDFFFFFF)),
              ),
            ),
          ]),
    );
  }

  /// 2️⃣ Sizes Demo 2 into view according to value of [_demo2Icon]
  Widget buildDemo2() {
    const icons = [
      Icons.ac_unit,
      Icons.access_alarm,
      Icons.accessibility,
      CustomIcons.logo_bugbash,
      Icons.accessible_forward,
      Icons.account_balance_wallet,
      Icons.account_box,
      Icons.account_tree,
      Icons.adb,
      Icons.agriculture,
      Icons.wine_bar,
      Icons.whatshot,
      Icons.weekend,
      Icons.android,
      Icons.assistant,
      CustomIcons.logo_bugbash,
      Icons.anchor,
      Icons.all_inclusive,
      Icons.looks,
      Icons.local_parking,
      Icons.design_services
    ];

    var i = 0; // Icon Key #id

    return Align(
      alignment: Alignment.topCenter,
      child: BackdropFilter(
          filter: (_demo2Icon == _ICON_CLOSE)
              ? ImageFilter.blur(sigmaX: 5, sigmaY: 5)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Material(
              color: Theme.of(context).backgroundColor.withOpacity(0.5),
              animationDuration: _DURATION,
              elevation: 50,
              child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.75),
                  onTap: () => setState(() {}),
                  child: AnimatedContainer(
                      duration: _DURATION,
                      curve: _CURVE,
                      width: _width,
                      // width: (_demo2Icon == _ICON_CLOSE) ? _width : 0,
                      height: (_demo2Icon == _ICON_CLOSE) ? _height : 0,
                      padding: EdgeInsets.all(25),
                      child: Column(children: [
                        /// 🛑 Wrapping [Icon]s
                        Expanded(
                          flex: 2,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Wrapping ',
                              style: _headline4,
                              children: [
                                TextSpan(
                                    text: 'Icon',
                                    style: _technical.copyWith(
                                        fontSize: _headline4.fontSize)),
                                TextSpan(
                                  text: 's\n',
                                ),
                                TextSpan(
                                    text:
                                        'with intermittent non-square IconData',
                                    style: _headline4.copyWith(fontSize: 16))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Wrap(children: [
                            for (IconData icon in icons)
                              Icon(
                                icon,
                                // color: Colors.white54,
                                color: Colors.accents[
                                        Random().nextInt(Colors.accents.length)]
                                    .withOpacity(0.5),
                                size: (_demo2Icon == _ICON_CLOSE) ? 50 : 10,
                                semanticLabel: 'an Icon by Flutter',
                                key: Key('Icon #${i++}: $icon:'),
                              )
                          ]),
                        ),

                        /// 🆕 Wrapping [IconToo]s
                        Expanded(
                          flex: 2,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Wrapping ',
                              style: _headline4,
                              children: [
                                TextSpan(
                                  text: 'IconToo',
                                  style: _technical.copyWith(
                                      fontSize: _headline4.fontSize),
                                ),
                                TextSpan(
                                  text: 's\n',
                                ),
                                TextSpan(
                                  text: 'with intermittent non-square IconData',
                                  style: _headline4.copyWith(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Wrap(children: [
                            for (IconData icon in icons)
                              IconToo(
                                icon,
                                // color: Colors.white54,
                                color: Colors.accents[
                                        Random().nextInt(Colors.accents.length)]
                                    .withOpacity(0.5),
                                trueSize: (icon == CustomIcons.logo_bugbash)
                                    ? Size(50 * _ICON_WIDTH_RATIO, 50)
                                    : Size(50, 50),
                                semanticLabel: 'an Icon Too from package Icon',
                                key: Key('IconToo #${i++}: $icon:'),
                                shadows: [
                                  Shadow(
                                    color: Colors.black38,
                                    blurRadius: 0,
                                    offset: Offset(1, 1),
                                  )
                                ],
                              )
                          ]),
                        ),
                        Flexible(
                          child: Text(
                            '✨ Plus Customizable Shadows!\nTap \'n hold to preview with a brighter background.',
                            textAlign: TextAlign.center,
                            style: _overline.copyWith(
                                letterSpacing: 0.6, shadows: _SHADOWS),
                          ),
                        ),
                      ]))))),
    );
  }

  /// 🌆 Loads a nice space picture from [APOD](https://apod.nasa.gov 'NASA APOD'),
  /// and when it has, fades this image in, fitted to cover the display.
  Image buildBackground() {
    return Image.network(
      'https://apod.nasa.gov/apod/image/2101/NGC1316Center_HubbleNobre_2585.jpg',

      /// This frameBuilder simply fades in the photo when it loads.
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: _DURATION,
          curve: _CURVE,
        );
      },

      /// Stretch the photo to the size of the app and have it cover the Surface.
      fit: BoxFit.cover,
      width: _width,
      height: _height,
    );
  }
}
