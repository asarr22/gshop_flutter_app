import 'package:flutter/material.dart';

class InfoDetailWidget extends StatelessWidget {
  const InfoDetailWidget({
    super.key,
    required this.title,
    required this.info,
  });

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          info,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
