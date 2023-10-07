import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef IsExpandedFunction = bool Function();

class SimpleExpanderHeader extends StatefulWidget {
  final String title;
  final Widget? trailing;
  final IsExpandedFunction isExpanded;
  final Color headerColor;
  final Color headerTextColor;
  final double headerHeight;

  // EVERYTHING REQUIRED BECAUSE WILL BE USED IN MY PACKAGE AND NOWHERE ELSE
  const SimpleExpanderHeader({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.trailing,
    required this.headerColor,
    required this.headerTextColor,
    required this.headerHeight,
  });

  @override
  State<SimpleExpanderHeader> createState() => _SimpleExpanderHeaderState();
}

class _SimpleExpanderHeaderState extends State<SimpleExpanderHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: widget.headerHeight,
      color: widget.headerColor,
      child: Row(
        children: [
          Icon(
            widget.isExpanded()
                ? FontAwesomeIcons.circleChevronUp
                : FontAwesomeIcons.circleChevronDown,
            color: Colors.white,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: widget.headerTextColor,
                fontSize: 20,
              ),
            ),
          ),
          widget.trailing ?? const SizedBox()
        ],
      ),
    );
  }
}
