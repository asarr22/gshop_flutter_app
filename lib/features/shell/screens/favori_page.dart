import 'package:flutter/material.dart';
import 'package:gshopp_flutter/features/shell/screens/favori.widgets/favorite_item_card.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {},
                  child: Text(
                    TextValue.clearAll,
                    style: Theme.of(context).textTheme.bodySmall!.apply(color: ColorPalette.primary, fontWeightDelta: 2),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return const FavoriteItemCard();
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SizesValue.padding),
        child: Container(
          margin: const EdgeInsets.only(bottom: 100),
          height: 60,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            child: Text(
              TextValue.addToCard,
              style: Theme.of(context).textTheme.labelLarge!.apply(color: ColorPalette.primary),
            ),
          ),
        ),
      ),
    );
  }
}
