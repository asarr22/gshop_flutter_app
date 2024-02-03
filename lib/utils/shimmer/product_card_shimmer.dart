import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.extraLightGrayPlus,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: ColorPalette.lightGrey,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: ColorPalette.lightGrey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Expanded(
            child: Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: ColorPalette.lightGrey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
