/// ## 🙋‍♂️ I'm an Icon Too!
/// This example is heavily (overly?) documented.
///
/// Hover over many terms in the code to see a description or explanation,
/// and [`Ctrl`]+[`Click`] to goto the definition (in most editors; maybe [`F12`]).
library icon_example;

import 'dart:math' show Random;
import 'dart:ui' show ImageFilter;
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:flutter/material.dart';

import 'package:icon/icon.dart';
import 'custom_icons.dart';
import 'icon_list.dart';
import 'demo3.dart';

/// The non-square icon's presentation height
/// for this example, utilized in the FABs and TabBar.
const ICON_SIZE = 20.0;

/// Title for this example in the AppBar.
const TITLE = 'Icon Example: Using an IconToo';

/// This [IconData] represents the state of Demo 2 being hidden
/// and is an open icon.
const DEMO2_IS_CLOSED = Icons.note_add_outlined;

/// This [IconData] represents the state of Demo 2 being shown
/// and is a close icon.
const DEMO2_IS_OPEN = Icons.cancel_outlined;

/// Constant for UI styling.
const DURATION = Duration(milliseconds: 500);

/// Constant for UI styling.
const CURVE = Curves.fastOutSlowIn;

void main() => runApp(IconExample());

/// This class is a [StatelessWidget] that, when built,
/// returns a [MaterialApp] with given properties.
///
/// The [MaterialApp.home] field defines the home page, [Landing].
class IconExample extends StatelessWidget {
  Widget build(BuildContext context) => MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: TITLE,
        home: const Landing(),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red,
            backgroundColor: const Color(0xFF550000),
          ),
        ).copyWith(textTheme: ThemeData(brightness: Brightness.dark).textTheme),
      );
}

/// This class is a [StatefulWidget] that creates a [State],
/// [LandingState], when Flutter requests it.
class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);
  LandingState createState() => LandingState();
}

/// This class is a [State] with [Type] of [Landing],
/// `with` the mixin [TickerProviderStateMixin]
/// in order to accommodate a [TabBar] for its [Scaffold].
///
/// Like a [MaterialApp], a [Scaffold] is used less frequently than
/// other styling [Widgets]--generally once per "page" or "view".
class LandingState extends State<Landing> with TickerProviderStateMixin {
  /// These TextStyles are initialized `late`r, once this `LandingState` is built.
  late TextStyle technical, overline, headline4, headline1;
  // These doubles are provided the width and height of the screen `late`r.
  late double width, height;

  /// The AppBar leading IconButton toggles the second demo.
  /// Initialize the IconData value for the button here.
  ///
  /// We will control other stateful UI elements with this value.
  IconData demo2Icon = DEMO2_IS_CLOSED;

  /// Because this is a sample app...
  int _counter = 0;

  /// Because this is a sample app...
  void incrementCounter() => setState(() => _counter++);

  Widget build(BuildContext context) {
    // Force portrait orientation.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // Store display resolution.
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    /// Shortcut some `TextStyle`s that originate from `Theme.of`
    overline = Theme.of(context).textTheme.overline!.copyWith(shadows: SHADOWS);
    technical = Theme.of(context).textTheme.subtitle2!.copyWith(
          fontFamily: 'serif',
          fontWeight: FontWeight.bold,
          shadows: SHADOWS,
          fontSize: 10,
        );
    headline1 = Theme.of(context).textTheme.headline1!.copyWith(
          shadows: SHADOWS,
          color: const Color(0xFFFFFFFF),
        );
    headline4 = Theme.of(context).textTheme.headline4!.copyWith(
          shadows: SHADOWS,
          color: const Color(0xFFFFFFFF),
        );

    /// Return this built `LandingState`.
    return Scaffold(
      body: Stack(children: [
        buildBackground(),
        buildBody(),
        maybeBuildDemo2(), // This build methods checks the value of `demo2Icon`.
      ]),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(TITLE, style: TextStyle(shadows: SHADOWS)),
        elevation: (demo2Icon == DEMO2_IS_CLOSED) ? 0 : 50,

        // Tapping the AppBar leading button will toggle the IconData for
        // `demo2Icon` which is used to toggle visibility of Demo 2.
        leading: IconButton(
          // This IconToo with default params would be visually equivalent
          // to a standard Icon, but elect to pass 👥 `shadows`.
          icon: IconToo(demo2Icon, shadows: SHADOWS),
          tooltip: 'Toggle Demo 2: Wrapping Icons',
          onPressed: () => setState(() => demo2Icon =
              // If it is one IconData, make it the other.
              (demo2Icon == DEMO2_IS_OPEN) ? DEMO2_IS_CLOSED : DEMO2_IS_OPEN),
        ),

        actions: [
          IconButton(
            icon: IconToo(demo2Icon, shadows: SHADOWS),
            tooltip: 'Toggle Demo 2: Wrapping Icons',
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Demo3())),
          )
        ],

        bottom: TabBar(
          controller: TabController(vsync: this, length: 1),
          tabs: [
            Tab(
              icon: IconToo(
                CustomIcons.logo_bugbash,
                sizeX: ICON_SIZE * ICON_WIDTH_RATIO,
                sizeY: ICON_SIZE,
                shadows: SHADOWS,
              ),
            )
          ],
        ),
      ),

      // 🔤 Floating Action Buttons demonstrating the alignment and
      // sizing issues of non-square IconData in traditional Icons.
      floatingActionButton: AnimatedOpacity(
        duration: DURATION,
        curve: CURVE,
        opacity: (demo2Icon == DEMO2_IS_OPEN) ? 0 : 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 🔘 `Icon` for `IconButton` with shortest-side `iconSize`
            // * Broken.
            buildFAB(
              label: 'Icon 🔻\nIconButton\nShortest Side',
              textStyle: technical,
              child: buildIconButton(
                icon: const Icon(
                  CustomIcons.logo_bugbash,
                  size: ICON_SIZE,
                  color: Colors.white,
                ),
                // Provide shortest-side [iconSize]; result is left-edge of
                // icon is centered in a circle too small to fit anyway.
                iconSize: ICON_SIZE,
                tooltip:
                    'Typical experience with non-square Icons in IconButtons',
              ),
            ),

            // 🔘 `Icon` for `IconButton` with longest-side `iconSize`
            // * Broken.
            buildFAB(
              label: 'Icon 🔻\nIconButton\nLongest Side',
              textStyle: technical,
              child: buildIconButton(
                icon: const Icon(
                  CustomIcons.logo_bugbash,
                  size: ICON_SIZE,
                  color: Colors.white,
                ),
                // Provide longest-side [iconSize]; result is left-edge of
                // icon is centered in a circle wide enough to fit.
                iconSize: ICON_SIZE * ICON_WIDTH_RATIO,
                tooltip:
                    'IconButton passed an iconSize larger than Icon, but problem persists',
              ),
            ),

            // 🔘 `IconToo` for `IconButton` with longest-side `iconSize`
            // * Works!.
            buildFAB(
              label: 'IconToo 🔻\nIconButton\nLongest Side',
              textStyle: technical,
              child: buildIconButton(
                icon: const IconToo(
                  CustomIcons.logo_bugbash,
                  sizeX: ICON_SIZE * ICON_WIDTH_RATIO, sizeY: ICON_SIZE,
                  color: Colors.white,
                  shadows: SHADOWS, // 👥 `shadows` bonus!
                ),
                // Provide longest-side [iconSize]; result is
                // centered icon in a circle wide enough to fit.
                iconSize: ICON_SIZE * ICON_WIDTH_RATIO,
                tooltip:
                    'IconToo extends Icon but provides a trueSize SizedBox',
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔘 Set-up [IconButton] with matching parameters.
  ///
  /// Builds a black [Container] whose `child`
  /// is an [IconButton] with provided [icon], [iconSize], and [tooltip],
  /// that `onPressed` calls [incrementCounter].
  Widget buildIconButton({
    required Icon icon,
    required double iconSize,
    required String tooltip,
  }) =>
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black38,
        ),
        child: IconButton(
          icon: icon,
          iconSize: iconSize,
          tooltip: tooltip,
          onPressed: incrementCounter,
        ),
      );

  /// 🔤 Builds a short [Column] requiring a
  /// [label] styled by [textStyle] and a [child]; which, in the case
  /// of this example, will be [buildIconButton].
  ///
  /// Ignore touch input with [IgnorePointer] if 2️⃣ Demo2 is open.
  Widget buildFAB({
    required String label,
    required TextStyle textStyle,
    required Widget child,
  }) =>
      IgnorePointer(
        ignoring: (demo2Icon == DEMO2_IS_OPEN),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            child,
          ],
        ),
      );

  /// 👕 Returns the content on the main page of this example application.
  ///
  /// Will be obscured if 2️⃣ Demo2 is open.
  Padding buildBody() => Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'A nice, basic counter example\n'.toUpperCase(),
                  style: overline,
                  children: [
                    TextSpan(
                      text: 'Number of ',
                      style: headline4,
                    ),
                    TextSpan(
                      text: '~',
                      style: headline4
                          .merge(TextStyle(fontFamily: 'BashinBugs-Stripped')),
                    ),
                    TextSpan(text: '\nbutton presses:', style: headline4),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: DURATION,
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
                  style: headline1,
                ),
              ),
              Spacer(),
              Flexible(
                child: Text(
                  'ICON_SIZE = $ICON_SIZE\nICON_WIDTH_RATIO = $ICON_WIDTH_RATIO',
                  style: technical.copyWith(fontSize: 24),
                ),
              ),
              Flexible(
                child: Text(
                  'The IconData used in this example, [CustomIcons.logo_bugbash], is four times wider than it is tall. Literally, the width of the glyph is 4000 while others typically have a width of 1000.',
                  style: overline.copyWith(
                    letterSpacing: -0.25,
                    fontSize: 18,
                    color: const Color(0xDDFFFFFF),
                  ),
                ),
              ),
            ]),
      );

  /// 2️⃣ Sizes Demo 2 into view according to value of [demo2Icon].
  ///
  /// TODO: Make Demo2 a separate `class`.
  Widget maybeBuildDemo2() {
    // Icon Key #id, increments with every Icon
    var i = 0;

    // This method will be used twice, once for `Icon`s and again for `IconToo`s.
    Expanded buildDemo2Wrap({required List<Icon> children}) =>
        Expanded(flex: 5, child: Wrap(children: children));

    // A set-up RichText, ready for a single `String`.
    Expanded buildDemo2Header({required String technicalText}) => Expanded(
          flex: 2,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Wrapping ',
              style: headline4,
              children: [
                TextSpan(
                  text: technicalText,
                  style: technical.copyWith(
                    fontSize: headline4.fontSize,
                  ),
                ),
                const TextSpan(text: 's\n'),
                TextSpan(
                  text: 'with intermittent non-square IconData',
                  style: headline4.copyWith(fontSize: 16),
                )
              ],
            ),
          ),
        );

    // An aligned Material surface with InkWell and BackdropFilter.
    Widget buildDemo2Body({required Widget child}) => Align(
          alignment: Alignment.topCenter,
          child: BackdropFilter(
            filter: (demo2Icon == DEMO2_IS_OPEN)
                ? ImageFilter.blur(sigmaX: 5, sigmaY: 5)
                : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Material(
              color: Theme.of(context).backgroundColor.withOpacity(0.5),
              animationDuration: DURATION,
              elevation: 50,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Theme.of(context).primaryColor.withOpacity(0.75),
                onTap: () => setState(() {}),
                child: AnimatedContainer(
                  width: width,
                  height: (demo2Icon == DEMO2_IS_OPEN) ? height : 0,
                  duration: DURATION,
                  curve: CURVE,
                  padding: const EdgeInsets.all(25),
                  child: child,
                ),
              ),
            ),
          ),
        );

    /// Return the built 2️⃣ Demo2.
    return buildDemo2Body(
      child: Column(
        children: (demo2Icon == DEMO2_IS_CLOSED)
            ? const []
            : <Widget>[
                /// 🛑 Wrapping [Icon]s
                buildDemo2Header(technicalText: 'Icon'),
                buildDemo2Wrap(
                  children: <Icon>[
                    for (IconData icon in ICONS)
                      Icon(
                        icon,
                        size: 50,
                        key: Key('Icon#${i++}:$icon:'),
                        semanticLabel: 'an Icon from Flutter',
                        // Random MaterialColor with 50% opacity to show overlap
                        color: Colors
                            .primaries[Random().nextInt(Colors.accents.length)]
                            .withOpacity(0.5),
                      )
                  ],
                ),

                /// 🆕 Wrapping [IconToo]s
                buildDemo2Header(technicalText: 'IconToo'),
                buildDemo2Wrap(
                  // [IconToo]s extend [Icon]
                  children: <Icon>[
                    for (IconData icon in ICONS)
                      IconToo(
                        icon,
                        sizeX: (icon == CustomIcons.logo_bugbash)
                            ? 50 * ICON_WIDTH_RATIO
                            : 50,
                        sizeY: 50,
                        key: Key('IconToo#${i++}:$icon:'),
                        semanticLabel: 'an IconToo from package Icon',
                        // Random MaterialColor with 50% opacity to show overlap
                        color: Colors
                            .primaries[Random().nextInt(Colors.accents.length)]
                            .withOpacity(0.5),
                        // 👥 Yay, shadows! This List is `const` which saves memory.
                        shadows: const [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 0,
                            offset: Offset(1, 1),
                          ),
                        ],
                      )
                  ],
                ),

                // Tip about `shadows` support
                Flexible(
                  child: Text(
                    '👥 Plus custom shadows!\nTap \'n hold to preview with a brighter background.',
                    textAlign: TextAlign.center,
                    style:
                        overline.copyWith(letterSpacing: 0.6, shadows: SHADOWS),
                  ),
                ),
              ],
      ),
    );
  }

  /// 🌆 Loads a nice space picture from [APOD](https://apod.nasa.gov 'NASA APOD'),
  /// and when it has, fades this image in, fit to cover the display.
  Image buildBackground() => Image.network(
        'https://apod.nasa.gov/apod/image/2101/NGC1316Center_HubbleNobre_2585.jpg',
        // Stretch the photo to the size of the app.
        fit: BoxFit.cover,
        width: width,
        height: height,

        // This frameBuilder fades in the photo when it loads.
        //
        // A static picture has `1` frame, but `null` if it is not loaded.
        // (An animated GIF would have more than one frame, as an example.)
        frameBuilder: (_, child, frame, wasLoaded) {
          if (wasLoaded) return child; // Return picture if loaded, otherwise:
          return AnimatedOpacity(
            child: child,
            opacity: frame == null ? 0 : 1, // `frame==null` before loading
            duration: DURATION, // Fade from 0->1 `opacity` over this duration
            curve: CURVE, // Curves describe the "shape" or "how" of animation
          );
        },
      );
}
