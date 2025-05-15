import '../utilities/constants.dart';
import 'package:flutter/material.dart';

class ViewTitle extends StatelessWidget {
  final String title;
  const ViewTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15),
      padding: const EdgeInsets.all(3),
      color: Constants.darkGreySecondary,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            ' $title',
            style: const TextStyle(
              color: Constants.lighterGrey,
              fontSize: Constants.normalFontSize,
            ),
          )
        ],
      ),
    );
  }
}
