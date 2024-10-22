import 'package:flutter/material.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText(
      {super.key,
      required this.image,
      required this.title,
      this.backgroundColor,
      this.onTap,
      this.firstItemPadding = false});

  final String image, title;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool firstItemPadding;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(firstItemPadding ? 20 : 0, 0, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 55,
              width: 55,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: backgroundColor ?? (isDarkMode ? Colors.white : Colors.white),
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  // BoxShadow(
                  //   color: Colors.grey.withOpacity(0.5),
                  //   spreadRadius: 5,
                  //   blurRadius: 10,
                  //   offset: const Offset(0, 3), // changes position of shadow
                  // ),
                ],
              ),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 85,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.apply(fontWeightDelta: 2),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
