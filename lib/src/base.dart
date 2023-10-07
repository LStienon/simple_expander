import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:simple_expander/src/_content.dart';

import '_header.dart';
import 'tile.dart';

typedef SaveExpandStateCallback = void Function();

class SimpleExpander extends StatefulWidget {
  final String headerString;
  final Widget? headerTrailing;
  final Color headerColor;
  final Color headerTextColor;
  final List<SimpleExpanderTile> tiles;
  final double curve;
  final double baseHeight;
  final SaveExpandStateCallback? saveStateFunction;
  final bool initiallyExpanded;
  final bool durationOnTiles;
  final int milliseconds;
  // IF TRUE, GIVEN DURATION IN MILLISECONDS IS TIME PASSED OVER EACH TILE AND NOT FOR THE WHOLE ANIMATION

  const SimpleExpander({super.key,
    required this.headerString,
    required this.tiles,
    this.milliseconds = 125,
    this.initiallyExpanded = false,
    this.durationOnTiles = false,
    this.headerTrailing,
    this.curve = 20,
    this.baseHeight = 70,
    this.saveStateFunction,
    this.headerColor = CupertinoColors.systemGrey,
    this.headerTextColor = Colors.white
  });

  @override
  State<SimpleExpander> createState() => _SimpleExpanderState();
}

class _SimpleExpanderState extends State<SimpleExpander> {
  final GlobalKey _key = GlobalKey();
  late bool _isExpanded;
  late double? _contentHeight;
  late Duration _animationDuration;

  @override
  void initState() {
    _animationDuration = widget.durationOnTiles ? Duration(milliseconds: widget.tiles.length * widget.milliseconds) : Duration(milliseconds: widget.milliseconds);

    super.initState();

    _contentHeight = widget.baseHeight;
    _isExpanded = widget.initiallyExpanded;

    // THIS IS CALLED DIRECTLY AFTER BUILD SO WHEN CONTEXT IS FINALLY AVAILABLE
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _contentHeight = _isExpanded ? widget.baseHeight + _key.currentContext!.size!.height : widget.baseHeight;
      });
    });
  }

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      _contentHeight = _isExpanded ? widget.baseHeight + _key.currentContext!.size!.height : widget.baseHeight;
    });
    if (widget.saveStateFunction != null) {
      widget.saveStateFunction!();
    }
  }

  // LITTLE LIVE UPDATER FOR DX, WHEN CHANGING THE BASE HEIGHT
  @override
  void didUpdateWidget(covariant SimpleExpander oldWidget) {
    if (oldWidget.baseHeight != widget.baseHeight) {
      // WE FIRST NEED TO REBUILD TO GET THE NEW SIZE
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _contentHeight = _isExpanded ? widget.baseHeight + _key.currentContext!.size!.height : widget.baseHeight;
        });
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.curve),
      child: AnimatedContainer(
        duration: _animationDuration,
        height: _contentHeight,
        child: Wrap(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: toggleExpand,
                  child: SimpleExpanderHeader(
                    title: widget.headerString,
                    headerColor: widget.headerColor,
                    headerTextColor: widget.headerTextColor,
                    trailing: widget.headerTrailing,
                    isExpanded: () => _isExpanded,
                    headerHeight: widget.baseHeight,
                  ),
                ),
                SimpleExpanderContent(
                  key: _key,
                  tiles: widget.tiles,
                  baseHeight: widget.baseHeight,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
