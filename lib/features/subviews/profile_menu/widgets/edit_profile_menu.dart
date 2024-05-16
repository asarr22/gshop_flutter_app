import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PEditProfileMenu extends StatelessWidget {
  const PEditProfileMenu(
      {super.key,
      this.icon = Iconsax.arrow_right_34,
      required this.onPressed,
      required this.title,
      required this.value});
  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.apply(fontSizeFactor: 1.2),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeFactor: 1),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(icon, size: 18)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
