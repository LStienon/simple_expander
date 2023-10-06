import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnTapFunction = Future<void> Function();

class SimpleExpanderTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final OnTapFunction onTap;
  final Widget? trailing;
  final bool lastInList;
  final double curve;

  const SimpleExpanderTile({super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.curve,
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
                  bottomLeft: Radius.circular(widget.lastInList ? widget.curve : 0),
                  bottomRight: Radius.circular(widget.lastInList ? widget.curve : 0)
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