import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnTapCallback = Future<void> Function();
typedef ShowPopupMenuCallback = void Function(RelativeRect);

class SimpleExpanderTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final OnTapCallback onTap;
  final ShowPopupMenuCallback? showPopupMenuFunction;
  final Widget? trailing;
  final bool lastInList;
  final Color tileColor;
  final Color separatorColor;
  final double? height;

  const SimpleExpanderTile({
    super.key,
    required this.title,
    required this.onTap,
    this.tileColor = CupertinoColors.systemGrey5,
    this.lastInList = false,
    this.separatorColor = CupertinoColors.systemGrey,
    this.height,
    this.subtitle,
    this.trailing,
    this.showPopupMenuFunction,
  });

  @override
  State<SimpleExpanderTile> createState() => _SimpleExpanderTileState();
}

class _SimpleExpanderTileState extends State<SimpleExpanderTile> {
  late RelativeRect currentPopupPosition;

  void _updatePopupPosition(Offset offset) {
    double left = offset.dx;
    double top = offset.dy;
    currentPopupPosition = RelativeRect.fromLTRB(
        left - 50, top - 50, left, top); // ARBITRAIREMENT UN PEU PLUS CENTRE
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTapDown: (TapDownDetails details) {
              _updatePopupPosition(details.globalPosition);
            },
            onLongPress: widget.showPopupMenuFunction != null
                ? () => widget.showPopupMenuFunction!(currentPopupPosition)
                : null,
            onTap: widget.onTap,
            child: Container(
              color: widget.tileColor,
              height: widget.height,
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 20),
                          ),
                          if (widget.subtitle != null)
                            Text(
                              widget.subtitle!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),

                    // TRAILING PART
                    if (widget.trailing != null) widget.trailing!
                  ],
                ),
              ),
            )),
        if (!widget.lastInList)
          Divider(thickness: 2, color: widget.separatorColor, height: 1)
      ],
    );
  }
}
