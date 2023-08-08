import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/main.dart';

class ReceptCard extends StatelessWidget {
  ReceptCard({
    Key? key,
    this.src = "assets/images/r.jpg",
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  String src = "assets/images/r.jpg";
  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        extentRatio: 0.5,
        motion: const ScrollMotion(),
        dragDismissible: false,
        children: <Widget>[
          SlidableAction(
            onPressed: (BuildContext context) {
              final s = Slidable.of(context);
            },
            backgroundColor: Colors.white,
            foregroundColor: AppColor.green,
            icon: Icons.close,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(image: AssetImage(src), fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 22, top: 8),
                  alignment: Alignment.topRight,
                  height: 80,
                  child: const Icon(
                    Icons.favorite_outline_rounded,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(17),
                  width: double.infinity,
                  color: const Color.fromRGBO(0, 0, 0, 0.7),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/knife-fork.svg',
                                  semanticsLabel: 'Label',
                                  fit: BoxFit.scaleDown,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  subtitle,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(196, 196, 196, 1)),
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  'assets/icons/circle-plus.svg',
                                  fit: BoxFit.scaleDown,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
