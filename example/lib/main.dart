import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_icons.dart';
import 'package:icon/icon.dart';

/// Whatever we would like the icon to be sized to for this example.
const _ICON_SIZE = 20.0;

/// The IconData used in this example, [CustomIcons.logo_bugbash], is four times
/// wider than it is tall.
/// Literally, the width of the glyph is 4000 while others typically have a width of 1000.
const _ICON_WIDTH_RATIO = 4.0;

/// Some constants for basic UI styling.
const _SHADOWS = [Shadow(offset: Offset(0, 1))];
const _DURATION = Duration(milliseconds: 600);
const _CURVE = Curves.fastOutSlowIn;

void main() {
  runApp(IconExample());
}

class IconExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Icon Example: Using an IconToo',
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

class _LandingState extends State<Landing> {
  double _width, _height;
  int _counter = 0;
  TextStyle _technical, _overline, _headline4, _headline1;

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
        title: Text('IconToo Example'),

        /// TODO: Show an example where a wrapped series of [Icon]s would overlap
        /// with the occasional non-square IconData; and where the occasional
        /// non-square [IconToo] instead would properly space its neighbors.
        leading: IconButton(
          icon: Icon(Icons.note_add_outlined),
          tooltip:
              'TODO: Example with wrapped IconToos that do not overlap (Icons do)',
          onPressed: null,
        ),
      ),

      /// Scaffold Body
      body: Stack(children: [
        /// 🌆 Build Background
        buildBackground(),

        /// 👕 Build Body
        buildBody(),
      ]),

      /// FAB
      floatingActionButton: Row(
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
              tooltip: 'IconToo extends Icon but provides a trueSize SizedBox',
            ),
          ),
        ],
      ),
    );
  }

  /// 🔘 Returns a partially-transparent black Container
  /// whose child is an [IconButton] with passed [icon] and
  /// [iconSize] that onPressed calls [_incrementCounter].
  Widget exampleIconButton(
      {@required Icon icon, @required double iconSize, String tooltip}) {
    return Container(
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
            Text(
              'A nice, basic counter example'.toUpperCase(),
              style: _overline,
            ),
            RichText(
              text: TextSpan(
                text: 'Number of ',
                style: _headline4,
                children: [
                  TextSpan(
                    text: '~',
                    style: TextStyle(fontFamily: 'BashinBugs-Stripped'),
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
                color: Colors.accents[Random().nextInt(Colors.accents.length)]
                    .withOpacity(0.25),
                backgroundBlendMode: BlendMode.difference,
              ),
              child: Text(
                  (_counter < 10)
                      ? '0' + _counter.toString()
                      : _counter.toString(),
                  style: _headline1),
            ),
            Spacer(flex: 1),
            Flexible(
              flex: 1,
              child: Text(
                'const _ICON_SIZE = $_ICON_SIZE\nconst _ICON_WIDTH_RATIO = $_ICON_WIDTH_RATIO',
                style: _technical.copyWith(fontSize: 22),
              ),
            ),
            Text(
              'The IconData used in this example, [CustomIcons.logo_bugbash], is four times wider than it is tall. Literally, the width of the glyph is 4000 while others typically have a width of 1000.',
              style: _overline.copyWith(
                  letterSpacing: 0.25,
                  fontSize: 14,
                  color: const Color(0xDDFFFFFF)),
            ),
          ]),
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
