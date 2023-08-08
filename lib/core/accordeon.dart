import 'package:flutter/material.dart';

class Accordeon extends StatefulWidget {
  bool isExpanded = false;
  Widget child;
  Widget title;
  String id;
  EdgeInsets? padding;
  EdgeInsets? margin;
  BoxDecoration? containerDecoration;

  Accordeon({
    Key? key,
    required this.isExpanded,
    required this.child,
    required this.title,
    required this.id,
    this.padding,
    this.margin,
    this.containerDecoration,
  }) : super(key: key);

  @override
  State<Accordeon> createState() => _AccordeonState();
}

class _AccordeonState extends State<Accordeon> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.ease);

  void _animate() {
    widget.isExpanded ? _controller.forward() : _controller.reverse();
  }

  void _onTap() {
    setState(() {
      widget.isExpanded = !widget.isExpanded;
    });
    _animate();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 280),
      vsync: this,
    );

    _animate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(widget.id),
      padding: widget.padding ?? const EdgeInsets.all(8),
      margin: widget.margin ?? const EdgeInsets.all(0),
      decoration: widget.containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _onTap(),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: widget.title,
                ),
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: widget.isExpanded
                        ? Container(
                            key: const ValueKey(2),
                            child: const Icon(Icons.keyboard_arrow_up_rounded),
                          )
                        : Container(
                            key: const ValueKey(1),
                            child:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                          )),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            axisAlignment: -1,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
