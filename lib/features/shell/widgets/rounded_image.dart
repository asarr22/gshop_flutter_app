import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imgUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = ColorPalette.backgroundLight,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = false,
    this.isFileImage = false,
    this.onPressed,
    this.borderRadius = 20,
    this.boxShadow,
  });

  final double? width, height;
  final String imgUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final bool isFileImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: imgUrl.isEmpty
            ? Container(
                color: ColorPalette.extraLightGray,
                child: Center(
                  child: Icon(Iconsax.image, size: height! / 3),
                ),
              )
            : ClipRRect(
                borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
                child: isNetworkImage
                    ? CachedNetworkImage(
                        imageUrl: imgUrl,
                        fit: fit,
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      )
                    : Image(
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorPalette.primary,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        image: isNetworkImage
                            ? NetworkImage(imgUrl)
                            : isFileImage
                                ? FileImage(File(imgUrl))
                                : AssetImage(imgUrl) as ImageProvider,
                        fit: fit,
                      ),
              ),
      ),
    );
  }
}
