import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/order_controller.dart';
import 'package:gshopp_flutter/common/models/order/order_model.dart';
import 'package:gshopp_flutter/features/subviews/order_page/order_details_page.dart';
import 'package:gshopp_flutter/features/subviews/order_page/widget/custom_tab_bar.dart';
import 'package:gshopp_flutter/features/subviews/order_page/widget/order_item_card.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/global_value.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:iconsax/iconsax.dart';

class OrderPage extends ConsumerWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(tabIndexProvider);
    final onGoingList = ref.watch(orderControllerProvider)['ongoing'];
    final completedList = ref.watch(orderControllerProvider)['completed'];
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    List<Widget> contentWidgets = [
      // On Going Content
      onGoingOrder(onGoingList, isDarkMode, context),
      // Completed Content
      completedOrder(completedList, isDarkMode, context),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        title: Text(
          TextValue.myOrders,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomOrderTabBar(),
        ),
      ),
      body: contentWidgets[selectedIndex],
    );
  }

  Padding onGoingOrder(List<OrderModel>? onGoingList, bool isDarkMode, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding, vertical: SizesValue.padding / 2),
      child: onGoingList!.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.document, size: 100, color: isDarkMode ? Colors.white : Colors.black),
                  const SizedBox(height: SizesValue.spaceBtwItems),
                  Text(
                    TextValue.noItem,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: onGoingList.length,
                  itemBuilder: (__, index) {
                    final order = onGoingList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ExpansionTile(
                        maintainState: true,
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        collapsedBackgroundColor:
                            isDarkMode ? const Color.fromARGB(255, 71, 66, 59) : ColorPalette.extraLightGrayPlus,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        backgroundColor: isDarkMode ? ColorPalette.containerDark : ColorPalette.containerLight,
                        initiallyExpanded: true,
                        title: Text(
                          '${TextValue.order} N-${order.orderID}',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(fontWeightDelta: 2),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Icon(
                          GlobalValue.orderStateIconsMap[order.orderStatus.toString()],
                          color: GlobalValue.orderStateColorsMap[order.orderStatus.toString()],
                          size: 20,
                        ),
                        subtitle: Text(
                          GlobalValue.orderStateTextMap[order.orderStatus.toString()]!,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        children: [
                          onGoingList[index].orderItems.isNotEmpty
                              ? SizedBox(
                                  width: double.infinity,
                                  child: ListView.builder(
                                      itemCount: onGoingList[index].orderItems.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (_, innerindex) {
                                        final item = onGoingList[index].orderItems[innerindex];
                                        return OrderItemCard(
                                          orderItem: item,
                                        );
                                      }),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                      TextValue.noItem,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  )),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SizesValue.padding / 2,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      TextValue.total,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      Formatter.formatPrice(order.totalAmount),
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: SizesValue.spaceBtwSections),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => Get.to(() => OrderDetailsPage(onGoingList[index])),
                                    child: Text(
                                      TextValue.seeDetails,
                                      style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: SizesValue.spaceBtwItems),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  }),
            ),
    );
  }

  Padding completedOrder(List<OrderModel>? completedList, bool isDarkMode, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding, vertical: SizesValue.padding / 2),
      child: completedList!.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.document, size: 100, color: isDarkMode ? Colors.white : Colors.black),
                  const SizedBox(height: SizesValue.spaceBtwItems),
                  Text(
                    TextValue.noItem,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: completedList.length,
                  itemBuilder: (__, index) {
                    final order = completedList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ExpansionTile(
                        maintainState: true,
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        collapsedBackgroundColor:
                            isDarkMode ? const Color.fromARGB(255, 71, 66, 59) : ColorPalette.extraLightGrayPlus,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        backgroundColor: isDarkMode ? ColorPalette.containerDark : ColorPalette.containerLight,
                        initiallyExpanded: true,
                        title: Text(
                          '${TextValue.order} N-${order.orderID}',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(fontWeightDelta: 2),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Icon(
                          GlobalValue.orderStateIconsMap[order.orderStatus.toString()],
                          color: GlobalValue.orderStateColorsMap[order.orderStatus.toString()],
                          size: 20,
                        ),
                        subtitle: Text(
                          GlobalValue.orderStateTextMap[order.orderStatus.toString()]!,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        children: [
                          completedList[index].orderItems.isNotEmpty
                              ? SizedBox(
                                  width: double.infinity,
                                  child: ListView.builder(
                                      itemCount: completedList[index].orderItems.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (_, innerindex) {
                                        final item = completedList[index].orderItems[innerindex];
                                        return OrderItemCard(
                                          orderItem: item,
                                        );
                                      }),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                      TextValue.noItem,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  )),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SizesValue.padding / 2,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      TextValue.total,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      Formatter.formatPrice(order.totalAmount),
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: SizesValue.spaceBtwSections),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => Get.to(() => OrderDetailsPage(completedList[index])),
                                    child: Text(
                                      TextValue.seeDetails,
                                      style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: SizesValue.spaceBtwItems),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  }),
            ),
    );
  }

  // Tabbed Page Content
}
