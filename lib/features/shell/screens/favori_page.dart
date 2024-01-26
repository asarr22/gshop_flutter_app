import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/favorite_controller.dart';
import 'package:gshopp_flutter/features/shell/screens/favori.widgets/favorite_item_card.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteList = ref.watch(favoriteControllerProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.center,
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
                child: InkWell(
                  onTap: () {
                    ref.read(favoriteControllerProvider.notifier).clearAll();
                  },
                  child: Text(
                    TextValue.clearAll,
                    style:
                        Theme.of(context).textTheme.bodySmall!.apply(color: ColorPalette.primary, fontWeightDelta: 2),
                  ),
                ),
              ),
              favoriteList.isEmpty
                  ? const Center(
                      child: Text(TextValue.noItem),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: favoriteList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            final product = favoriteList[index];
                            return FavoriteItemCard(
                              favoriteItem: product,
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(SizesValue.padding),
      //   child: Container(
      //     margin: const EdgeInsets.only(bottom: 100),
      //     height: 60,
      //     width: double.infinity,
      //     child: OutlinedButton(
      //       onPressed: () {},
      //       child: Text(
      //         TextValue.addToCard,
      //         style: Theme.of(context).textTheme.labelLarge!.apply(color: ColorPalette.primary),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
