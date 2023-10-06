import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_expander/simple_expander_base.dart';

typedef OnTapFunction = Future<void> Function();

class SimpleExpanderTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final OnTapFunction onTap;
  final Widget? trailing;
  final bool lastInList;
  final Color tileColor;
  final Color separatorColor;

  const SimpleExpanderTile({super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.tileColor = CupertinoColors.systemGrey5,
    this.trailing,
    this.lastInList = false,
    this.separatorColor = CupertinoColors.systemGrey
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
            // FOR EVENTUAL POPUP MENU IMPLEMENTATION (UPDATE ITS APPEARING POSITION)
          },
          onLongPress: () {
            // FOR EVENTUAL POPUP MENU IMPLEMENTATION (ACTUALLY CALL THE SHOW POP MENU METHOD)
          },
          onTap: widget.onTap,
          child: Container(
            color: widget.tileColor,
            height: baseHeight,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                children: [

                  // MAIN PART WITH TITLE AND SUBTITLE
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20
                          ),
                        ),
                        if (widget.subtitle != null)
                          Text(
                            widget.subtitle!
                          ),
                      ],
                    ),
                  ),

                  // TRAILING PART
                  if (widget.trailing != null)
                    Expanded(
                      flex: 1,
                      child: widget.trailing!,
                    )

                ],
              ),
            ),
          )
        ),
        if (!widget.lastInList)
          Divider(thickness: 2, color: widget.separatorColor, height: 1)
      ],
    );
  }
}