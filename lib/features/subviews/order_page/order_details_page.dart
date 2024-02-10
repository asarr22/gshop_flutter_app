import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/models/order/order_model.dart';
import 'package:gshopp_flutter/features/subviews/order_page/widget/order_timeline_widget.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

class OrderDetailsPage extends ConsumerWidget {
  const OrderDetailsPage(this.orderModel, {super.key});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        title: Text(
          TextValue.orderDetails,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: TimelineOrderTracker(
        dates: orderModel.orderDateStatus,
        statuses: const [TextValue.orderPlaced, TextValue.confirmed, TextValue.orderDelivering, TextValue.delivered],
        descriptions: const [
          TextValue.orderPlacedDescription,
          TextValue.orderProcessingDescription,
          TextValue.orderDeliveringDescription,
          TextValue.orderDeliveredDescription,
        ],
        orderStatus: orderModel.orderStatus, // Only the first two items will be displayed
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SizesValue.padding),
        child: SizedBox(
          height: 60,
          child: Visibility(
            visible: orderModel.orderStatus < 2,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(TextValue.cancel),
            ),
          ),
        ),
      ),
    );
  }
}
