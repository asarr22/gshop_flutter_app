import 'package:flutter/material.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.onTap,
  });

  final String image, title;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 5, 0),
        child: Column(
          children: [
            Container(
              height: 56,
              width: 56,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: backgroundColor ??
                    (isDarkMode ? Colors.white : Colors.white),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
