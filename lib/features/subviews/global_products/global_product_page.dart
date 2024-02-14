import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/controllers/promo_event_controller.dart';
import 'package:gshopp_flutter/features/subviews/global_products/filter/filter_page.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/global_product_list.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/subcategories_menu.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/timer_widget.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/global_value.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class GlobalProductPage extends ConsumerStatefulWidget {
  const GlobalProductPage({super.key, required this.pageTitle, this.query, this.isFlashSale = false});
  final String pageTitle;
  final Query<Map<String, dynamic>>? query;
  final bool isFlashSale;

  @override
  ConsumerState<GlobalProductPage> createState() => _GlobalProductPageState();
}

class _GlobalProductPageState extends ConsumerState<GlobalProductPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(productControllerProvider.notifier).dispose();
    final notifier = ref.read(productControllerProvider.notifier);
    notifier.fetchProductWithCustomQuery(GlobalValue.defautQueryLimit, widget.query!);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final notifier = ref.read(productControllerProvider.notifier);
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && notifier.hasMore) {
      // Show Loading animation while fetching more products it will be disabled after fetching from fetchProductWithCustomQuery method

      ref.read(productControllerProvider.notifier).toggleRegularScrollLoading(true);

      /// Fetch more products
      /// Check if there is a filter query
      if (HelperFunctions.filterQueryHandler != null) {
        notifier.fetchProductWithCustomQuery(GlobalValue.scrollingQueryLimit, HelperFunctions.filterQueryHandler!);
      } else {
        notifier.fetchProductWithCustomQuery(GlobalValue.scrollingQueryLimit, widget.query!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isScrollLoading = ref.watch(productControllerProvider)['isRegularScrollLoading'] as bool;
    final event = widget.isFlashSale ? ref.watch(promoEventControllerProvider).firstWhere((e) => e.id == '0') : null;
    HelperFunctions.mainQueryHandler = widget.query!;
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            widget.pageTitle,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () {
            HelperFunctions.filterQueryHandler = null;
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.filter,
              color: isDarkMode ? ColorPalette.onPrimaryDark : ColorPalette.onPrimaryLight,
            ),
            onPressed: () => Get.to(() => ProductFilterPage(widget.query), transition: Transition.downToUp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            //
            // Category Filter (Disabled for now)
            const Visibility(
              visible: false,
              child: SubcategoriesMenu(),
            ),

            // Counter
            if (widget.isFlashSale) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${TextValue.endWithin} :',
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    CountdownWidget(
                      dateString: event!.endDate,
                      goBackWhenEventEnd: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],

            // List of Product
            const GlobalProductList(),
            Visibility(
                visible: isScrollLoading,
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
