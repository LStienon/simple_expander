import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef IsExpandedFunction = bool Function();

class SimpleExpanderHeader extends StatefulWidget {
  final String title;
  final Widget? trailing;
  final IsExpandedFunction isExpanded;

  const SimpleExpanderHeader({super.key,
    required this.title,
    required this.isExpanded,
    this.trailing
  });

  @override
  State<SimpleExpanderHeader> createState() => _SimpleExpanderHeaderState();
}

class _SimpleExpanderHeaderState extends State<SimpleExpanderHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 70,
      color: Colors.red,
      child: Row(
        children: [
          Icon(
            widget.isExpanded() ? FontAwesomeIcons.circleChevronUp : FontAwesomeIcons.circleChevronDown,
            color: Colors.white,
          ),
          const SizedBox(width: 15,),
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          const Spacer(),
          widget.trailing ?? const SizedBox()
        ],
      ),
    );
  }
}