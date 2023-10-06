import 'package:flutter/material.dart';
import 'package:simple_expander/first_try/simple_expander_first.dart';
import 'tile.dart';

class SimpleExpanderContent extends StatefulWidget {
  final List<SimpleExpanderTile> tiles;

  const SimpleExpanderContent({super.key,
    required this.tiles,
  });

  @override
  State<SimpleExpanderContent> createState() => _SimpleExpanderContentState();
}

class _SimpleExpanderContentState extends State<SimpleExpanderContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: widget.tiles.map((oneTile) {
          int currentIndex = widget.tiles.indexOf(oneTile);
          bool lastOne = currentIndex == widget.tiles.length - 1;

          return SimpleExpanderTile(
            title: oneTile.title,
            subtitle: oneTile.subtitle,
            onTap: oneTile.onTap,
            lastInList: lastOne,
            tileColor: oneTile.tileColor,
          );
        }).toList(),
      ),
    );
  }
}
