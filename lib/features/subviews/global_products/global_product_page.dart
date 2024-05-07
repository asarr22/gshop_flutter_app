import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/product_controller.dart';
import 'package:gshopp_flutter/common/controllers/promo_event_controller.dart';
import 'package:gshopp_flutter/features/subviews/global_products/filter/filter_page.dart';
import 'package:gshopp_flutter/features/subviews/global_products/state/global_product_order.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/global_product_list.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/subcategories_menu.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/timer_widget.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/global_value.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

/// Loads multiple products based on a provided query or filter.
///
/// This method fetches products dynamically, enabling efficient search and filtering
/// functionalities on the Global Product Page.
///
/// **Query:**
/// - Should not include limits or offsets. Use pagination separately for performance.
/// - Example: `FirebaseFirestore.instance.collection('Your_Collection').where(Your_Filter)`
///
/// **Returns:**
/// - A `Future<List<Product>>` resolving to a list of matching products.
///
///

class GlobalProductPage extends ConsumerStatefulWidget {
  const GlobalProductPage({
    super.key,
    required this.initialQuery,
    required this.pageTitle,
    this.isFlashSale = false,
  });

  final String pageTitle;
  final Query<Map<String, dynamic>>? initialQuery;
  final bool isFlashSale;

  @override
  ConsumerState<GlobalProductPage> createState() => _GlobalProductPageState();
}

class _GlobalProductPageState extends ConsumerState<GlobalProductPage> {
  ScrollController _scrollController = ScrollController();
  Query<Map<String, dynamic>>? query;
  @override
  void initState() {
    super.initState();
    query = widget.initialQuery;
    ref.read(productControllerProvider.notifier).dispose();
    final queryOrder = ref.read(globalProductOrderProvider);
    setQueryOrder(queryOrder);
    final notifier = ref.read(productControllerProvider.notifier);
    notifier.fetchProductWithCustomQuery(GlobalValue.defautQueryLimit, query!);
    _scrollController.addListener(_onScroll);
  }

  void reinitializePage() {
    _scrollController.dispose();
    _scrollController = ScrollController();
    query = widget.initialQuery;
    ref.read(productControllerProvider.notifier).dispose();
    final queryOrder = ref.read(globalProductOrderProvider);
    setQueryOrder(queryOrder);
    final notifier = ref.read(productControllerProvider.notifier);
    notifier.fetchProductWithCustomQuery(GlobalValue.defautQueryLimit, query!);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void setQueryOrder(ProductOrder queryOrder) {
    final isThereFilter = ref.read(productOrderFilterCheckerProvider);

    if (isThereFilter && GHelper.filterQueryHandler != null) {
      switch (queryOrder) {
        case ProductOrder.default_:
          query = GHelper.filterQueryHandler!.orderBy('id', descending: true);
          break;
        case ProductOrder.priceAsc:
          query = GHelper.filterQueryHandler!.orderBy('price', descending: false);
          break;
        case ProductOrder.priceDesc:
          query = GHelper.filterQueryHandler!.orderBy('price', descending: true);
          break;
      }
    } else {
      if (query == null) return;
      switch (queryOrder) {
        case ProductOrder.default_:
          query = query!.orderBy('id', descending: true);
          break;
        case ProductOrder.priceAsc:
          query = query!.orderBy('price', descending: false);
          break;
        case ProductOrder.priceDesc:
          query = query!.orderBy('price', descending: true);
          break;
      }
    }
  }

  void _onScroll() {
    final notifier = ref.read(productControllerProvider.notifier);
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && notifier.hasMore) {
      // Show Loading animation while fetching more products it will be disabled after fetching from fetchProductWithCustomQuery method

      ref.read(productControllerProvider.notifier).toggleRegularScrollLoading(true);

      /// Fetch more products
      /// Check if there is a filter query
      if (GHelper.filterQueryHandler != null) {
        notifier.fetchProductWithCustomQuery(GlobalValue.scrollingQueryLimit, GHelper.filterQueryHandler!);
      } else {
        notifier.fetchProductWithCustomQuery(GlobalValue.scrollingQueryLimit, query!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final queryOrder = ref.read(globalProductOrderProvider);
    final isScrollLoading = ref.watch(productControllerProvider)['isRegularScrollLoading'] as bool;
    final event = widget.isFlashSale ? ref.watch(promoEventControllerProvider).firstWhere((e) => e.id == '0') : null;
    GHelper.mainQueryHandler = widget.initialQuery!;
    bool isDarkMode = GHelper.isDarkMode(context);
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
            GHelper.filterQueryHandler = null;

            // Forcre disposing some item to avoid null error when returning to this page
            Get.back();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                Iconsax.setting_34,
                color: isDarkMode ? ColorPalette.onPrimaryDark : ColorPalette.onPrimaryLight,
              ),
              onPressed: () => Get.to(() => ProductFilterPage(query), transition: Transition.downToUp),
            ),
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
                    Hero(
                      tag: 'countdown',
                      child: ClipRect(
                        child: CountdownWidget(
                          dateString: event!.endDate,
                          goBackWhenEventEnd: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],

            const SizedBox(height: SizesValue.spaceBtwItems),

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
            const SizedBox(height: SizesValue.spaceBtwSections),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 120,
        child: FloatingActionButton(
          onPressed: () {
            _showPicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Iconsax.sort,
                color: Colors.white,
              ),
              const SizedBox(width: 5),
              Text(
                GHelper.getNameFromProductOrder(queryOrder),
                style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showPicker(BuildContext context) {
    bool isDarkMode = GHelper.isDarkMode(context);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          int selectedIndex = 0; // Initial selected index
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              height: 190,
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 40.0,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      children: List<Widget>.generate(ProductOrder.values.length, (int index) {
                        var item = ProductOrder.values[index];

                        return Center(
                          child: Text(
                            GHelper.getNameFromProductOrder(item),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        );
                      }),
                    ),
                  ),
                  CupertinoButton(
                    child: Text(
                      TextValue.apply,
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight, fontSizeDelta: 2),
                    ),
                    onPressed: () {
                      // Update the selected option using your provider here
                      ref.read(globalProductOrderProvider.notifier).update(ProductOrder.values[selectedIndex]);
                      reinitializePage();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
        });
  }
}
