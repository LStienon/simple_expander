import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:simple_expander/private_classes/_content.dart";

import 'private_classes/_header.dart';
import 'simple_expander_tile.dart';

class SimpleExpander extends StatefulWidget {
  final String headerString;
  final Widget? headerTrailing;
  final List<SimpleExpanderTile> tiles;
  final double? curve;
  final double? baseHeight;

  const SimpleExpander({super.key,
    required this.headerString,
    required this.tiles,
    this.headerTrailing,
    this.curve,
    this.baseHeight
  });

  @override
  State<SimpleExpander> createState() => _SimpleExpanderState();
}

class _SimpleExpanderState extends State<SimpleExpander> {
  final GlobalKey _key = GlobalKey();
  bool _isExpanded = false; // TODO : ADD INITIALLY EXPANDED ARG
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

