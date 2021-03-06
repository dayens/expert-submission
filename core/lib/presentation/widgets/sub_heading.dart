// ignore_for_file: use_key_in_widget_constructors

import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  final String title;
  final Function() onTap;

  const SubHeading({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
