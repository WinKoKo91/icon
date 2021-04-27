/// ##### **WORK IN PROGRESS**
/// ### A playground for various [Icon] / [IconToo]
/// # 🔣 `operator`s & 🗜️ [IconUtils]
/// Nearly every [IconToo] `operator` works the same in [IconUtils] as well.
///
/// The only differences (currently) are [IconToo.+], [IconToo.-], [IconToo.*],
/// all of which additionally (over [IconUtils]) accept a `List<num>` where
/// the first value applies to [IconToo.sizeX] and the second value to [IconToo.sizeY].
library icon_example;

import 'package:flutter/material.dart';
import 'package:icon/icon.dart';
import 'package:icon_example/custom_icons.dart';
import 'package:icon_example/icon_list.dart';

/// If the non-square [IconData] is *tall* and not *wide*,
/// opt for [IconToo.tall].
const _BASE_ICON = IconToo(
  CustomIcons.logo_bugbash,
  sizeX: 50.0 * ICON_WIDTH_RATIO,
  sizeY: 50.0,
  color: Colors.white,
  shadows: SHADOWS,
  // size: 50.0,
);

/// [BottomNavigationBarItem.label]
const _LABEL = 'Multiply by `Color`';

/// ### A playground for various [Icon] / [IconToo]
/// # 🔣 `operator`s
class Demo3 extends StatefulWidget {
  const Demo3({Key? key}) : super(key: key);
  _Demo3State createState() => _Demo3State();
}

class _Demo3State extends State<Demo3> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🗜️ Icon Extension Utilities')),

      // 💥 "Modulate" operator offers quick access to randomization,
      // either scale or color.
      body: ListView.builder(
          itemBuilder: (_, int index) =>
              (_BASE_ICON % [0, 0.25, 0.5, 0.75, 1.0]) % Colors.primaries),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: (_BASE_ICON - 20) & [40, 0, 0, 0], // Purely demonstrative
            iconSize: _BASE_ICON.asSize.longestSide,
            onPressed: () => setState(() {}), // Reset any random elements
          ),

          /// Whoa! `operator >(VoidCallback onTap)` method 😏
          _BASE_ICON * Colors.amber > () => setState(() {}),
        ],
      ),

      /// ❌ "Multiply" operator makes color-change on-the-fly easy-breezy.
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: _BASE_ICON * Colors.blue, label: _LABEL),
        BottomNavigationBarItem(icon: _BASE_ICON * Colors.green, label: _LABEL)
      ]),

      /// WIP
      drawer: Drawer(
        child: Wrap(
          children: <IconButton>[
            for (IconData icon in ICONS)
              IconToo(
                        icon,
                        sizeX: (icon == CustomIcons.logo_bugbash)
                            ? 12 * ICON_WIDTH_RATIO
                            : 12,
                        sizeY: 12,
                        color: Colors.white,
                      ) %
                      [1, 2, 3, 4, 5] >
                  () => setState(() {})
          ],
        ),
      ),
    );
  }
}
