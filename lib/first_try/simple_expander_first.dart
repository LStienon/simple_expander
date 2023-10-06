library simple_expander;

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:simple_expander/first_try/content.dart";

import "header.dart";
import "tile.dart";




class AnimatedSimpleExpander extends StatefulWidget {
  final String headerString;
  final Widget? headerTrailing;
  final List<SimpleExpanderTile> tiles;
  final double? curve;

  const AnimatedSimpleExpander({super.key,
    required this.headerString,
    required this.tiles,
    this.headerTrailing,
    this.curve,
  });

  @override
  State<AnimatedSimpleExpander> createState() => _AnimatedSimpleExpanderState();
}

class _AnimatedSimpleExpanderState extends State<AnimatedSimpleExpander> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _animationController;

  @override
  void initState() {
    if (widget.curve != null) {
      curve = widget.curve!;
    }
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    _isExpanded == true ? _animationController.forward() : _animationController.reverse();

  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(curve),
      child: Column(
        children: [
          GestureDetector(
            onTap: toggleExpand,
            child: SimpleExpanderHeader(
              title: widget.headerString,
              isExpanded: () => _isExpanded, // IT WORKS FINE !!
            ),
          ),

          // SUB WIDGET TO ANIMATE
          Animate(
            autoPlay: false,
            controller: _animationController,
            effects: [
              // VisibilityEffect(
              //   duration: Duration(milliseconds: 1)
              // ),
              SlideEffect(
                duration: Duration(milliseconds: 200),
                begin: Offset(0, -1.25),
                end: Offset(0, 0)
              )
            ],
            child: SimpleExpanderContent(
              tiles: widget.tiles,
              curve: curve,
            ),
          )

        ],
      ),
    );
  }
}



double curve = 20; // MADE TO HAVE THE SAME CURVE IN PARENT AND CHILD WIDGET




