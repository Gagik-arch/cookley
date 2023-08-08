import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  Screen({
    Key? key,
    this.header,
    required this.body,
    this.footer,
    this.padding,
  }) : super(key: key);

  final Widget? header;
  final Widget? body;
  final Widget? footer;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                Container(
                  child: header,
                ),
                Expanded(
                    child: Container(
                  padding: padding,
                  child: body,
                )),
                Container(
                  child: footer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
