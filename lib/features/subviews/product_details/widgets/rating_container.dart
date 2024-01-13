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
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imgUrl == "" ? 'https://cdn-icons-png.flaticon.com/512/147/147129.png' : imgUrl,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.labelLarge!.apply(fontWeightDelta: 2),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 15,
                          color: isDarkMode ? ColorPalette.lightGrey : ColorPalette.grey,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          date,
                          style: Theme.of(context).textTheme.labelSmall!.apply(fontSizeDelta: 1),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(color: ColorPalette.grey, fontWeightDelta: 1),
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
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment ?? "No comment",
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 5,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
