library simple_expander;

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:simple_expander/first_try/content.dart";

import "header.dart";
import "tile.dart";




class AnimatedSimpleExpander extends StatefulWidget {
  final String headerString;
  final Widget? headerTrailing;
  final List<SimpleExpanderTile> tiles;
  final double? curve;
  final double? baseHeight;

  const AnimatedSimpleExpander({super.key,
    required this.headerString,
    required this.tiles,
    this.headerTrailing,
    this.curve,
    this.baseHeight
  });

  @override
  State<AnimatedSimpleExpander> createState() => _AnimatedSimpleExpanderState();
}

class _AnimatedSimpleExpanderState extends State<AnimatedSimpleExpander> {
  final GlobalKey _key = GlobalKey();
  bool _isExpanded = false;
  double? _contentHeight = 70;

  @override
  void initState() {
    if (widget.curve != null) {
      curve = widget.curve!;
    }
    if (widget.baseHeight != null) {
      baseHeight = widget.baseHeight!;
    }
    super.initState();
  }

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      _contentHeight = _isExpanded ? baseHeight + _key.currentContext!.size!.height : baseHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(curve),
      child: AnimatedContainer(
        // TODO : CAN BE NICE TO FLY OVER EACH TILE THE SAME AMOUNT OF TIME
        // duration: Duration(milliseconds: 75 * widget.tiles.length),
        duration: const Duration(milliseconds: 125),
        height: _contentHeight,
        child: Wrap(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: toggleExpand,
                  child: SimpleExpanderHeader(
                    title: widget.headerString,
                    isExpanded: () => _isExpanded,
                  ),
                ),
                SimpleExpanderContent(
                  key: _key,
                  tiles: widget.tiles,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


double baseHeight = 70;
double curve = 20; // MADE TO HAVE THE SAME CURVE IN PARENT AND CHILD WIDGET




