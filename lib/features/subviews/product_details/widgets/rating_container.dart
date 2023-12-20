import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class RatingContainer extends StatelessWidget {
  const RatingContainer({
    super.key,
    required this.userName,
    this.comment,
    this.ratingValue = 0,
    required this.date,
    this.imgUrl = "",
  });

  final String userName;
  final String? comment;
  final double ratingValue;
  final String date;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Column(children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imgUrl == ""
                  ? 'https://cdn-icons-png.flaticon.com/512/147/147129.png'
                  : imgUrl),
            ),
            const SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 15,
                      color: isDarkMode
                          ? ColorPalette.lightGrey
                          : ColorPalette.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 80,
                    child: RichText(
                      text: TextSpan(
                        text: ratingValue.toString(),
                        style: Theme.of(context).textTheme.labelLarge,
                        children: <TextSpan>[
                          TextSpan(
                            text: " ${TextValue.ratings.toLowerCase()}",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  RatingBar.builder(
                    ignoreGestures: true,
                    itemSize: 13,
                    initialRating: ratingValue,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          comment ?? "No comment",
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 5,
        )
      ]),
    );
  }
}
