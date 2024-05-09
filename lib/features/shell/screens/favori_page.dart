import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/favorite_controller.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/product_card_vertical.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:gshopp_flutter/utils/shimmer/product_card_shimmer.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteList = ref.watch(favoriteControllerProvider);
    final isLoading = ref.watch(favoriteLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            TextValue.myFavorite,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 30,
                  width: 100,
                  child: InkWell(
                    onTap: () {
                      ref.read(favoriteControllerProvider.notifier).clearAll();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        TextValue.clearAll,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(color: ColorPalette.primary, fontWeightDelta: 2),
                      ),
                    ),
                  ),
                ),
              ),
              favoriteList!.isEmpty && !isLoading
                  ? SizedBox(
                      height: GHelper.screenHeight(context) - 200,
                      width: GHelper.screenWidth(context) - 40,
                      child: const Center(
                        child: RoundedImage(
                          imgUrl: ImagesValue.empty,
                          height: 100,
                          width: 100,
                          borderRadius: 0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    )
                  : GridView.builder(
                      itemCount: isLoading ? 4 : favoriteList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 220,
                      ),
                      itemBuilder: (_, index) {
                        if (isLoading) {
                          return const ProductCardShimmer();
                        } else {
                          Product product = favoriteList[index];
                          return ProductCardVertical(
                            product: product,
                          );
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
