import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class SimpleExpander extends StatefulWidget {
  final String headerString;
  final Widget? headerTrailing;
  final List<SimpleExpanderTile> tiles;
  final double? curve;

  const SimpleExpander({super.key,
    required this.headerString,
    required this.tiles,
    this.headerTrailing,
    this.curve,
  });

  @override
  State<SimpleExpander> createState() => _SimpleExpanderState();
}

class _SimpleExpanderState extends State<SimpleExpander> {
  bool _isExpanded = false;

  @override
  void initState() {
    if (widget.curve != null) {
      curve = widget.curve!;
    }
    super.initState();
  }

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(curve),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: toggleExpand,
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 70, // TODO : MAYBE ALLOW VARYING HEIGHT ?? THEN CHECK THE LISTTILES ....
              color: Colors.red,
              child: Row(
                children: <Widget>[
                  Icon(
                    _isExpanded ? FontAwesomeIcons.circleChevronUp : FontAwesomeIcons.circleChevronDown,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 15,),
                  Text(
                    widget.headerString,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  const Spacer(),
                  widget.headerTrailing ?? const SizedBox() // EMPTY BOX BECUASE NULL FORBIDDEN
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
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
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

typedef OnTapFunction = Future<void> Function();
double curve = 20; // MADE TO HAVE THE SAME CURVE IN PARENT AND CHILD WIDGET

class SimpleExpanderTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final OnTapFunction onTap;
  final Widget? trailing;
  final bool lastInList; // TODO : FIND BETTER WAY ??

  const SimpleExpanderTile({super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
    this.lastInList = false
  });

  @override
  State<SimpleExpanderTile> createState() => _SimpleExpanderTileState();
}

class _SimpleExpanderTileState extends State<SimpleExpanderTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            // FOR EVENTUAL POPUP MENU IMPLEMENTATION
          },
          child: ListTile(
            tileColor: CupertinoColors.systemGrey4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(widget.lastInList ? curve : 0),
                  bottomRight: Radius.circular(widget.lastInList ? curve : 0)
              ),
            ),
            title: Text(widget.title),
            subtitle: Text(widget.subtitle),
            trailing: widget.trailing,
            onTap: widget.onTap,
            onLongPress: () {
              // HERE CALL THE LOCAL WIDGET FUNCTION THAT POPS THE POPUP MENU
            },
          ),
        ),
        if (!widget.lastInList)
          const Divider(thickness: 2, color: Colors.blue, height: 1)
      ],
    );
  }
}


