import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

class TimelineOrderTracker extends StatelessWidget {
  final List<String> dates;
  final List<String> statuses;
  final List<String> descriptions;
  final int orderStatus;

  const TimelineOrderTracker({
    super.key,
    required this.dates,
    required this.statuses,
    required this.descriptions,
    required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    int itemCount = orderStatus == -1 ? 1 : orderStatus + 1;
    bool isFailedOrCancelled = orderStatus == -1;

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        bool isCompleted = index <= orderStatus;
        Color iconColor = isFailedOrCancelled
            ? Colors.red
            : isCompleted
                ? (isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight)
                : (isDarkMode ? Colors.white54 : Colors.black54);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Column(
                children: [
                  // Timeline Connector
                  Container(
                    width: 2.0,
                    height: 50.0,
                    color: isFailedOrCancelled || index == 0 || !isCompleted
                        ? Colors.transparent
                        : isDarkMode
                            ? ColorPalette.primaryDark
                            : ColorPalette.primaryLight,
                  ),
                  // Timeline Icon
                  Icon(
                    isFailedOrCancelled
                        ? Iconsax.close_circle
                        : isCompleted
                            ? Iconsax.tick_circle
                            : Iconsax.tick_circle5,
                    color: iconColor,
                  ),
                  // Timeline Connector
                  Container(
                    width: 2.0,
                    height: 50.0,
                    color: isFailedOrCancelled || index == itemCount - 1 || !isCompleted
                        ? Colors.transparent
                        : isDarkMode
                            ? ColorPalette.primaryDark
                            : ColorPalette.primaryLight,
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isDarkMode ? ColorPalette.containerDark : ColorPalette.containerLight,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: isFailedOrCancelled
                          ? []
                          : [
                              BoxShadow(
                                color: isDarkMode
                                    ? ColorPalette.primaryDark.withOpacity(0.8)
                                    : ColorPalette.primaryLight.withOpacity(0.8),
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                                offset: const Offset(0, 3),
                              ),
                            ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isFailedOrCancelled ? TextValue.orderFailedOrCancelled : statuses[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isFailedOrCancelled
                                    ? Colors.red
                                    : isCompleted
                                        ? (isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight)
                                        : (isDarkMode ? Colors.white : Colors.black),
                              ),
                            ),
                            if (!isFailedOrCancelled)
                              Text(
                                dates[index],
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                          ],
                        ),
                        Text(
                          isFailedOrCancelled ? TextValue.orderFailedOrCancelledDescription : descriptions[index],
                          style: TextStyle(
                            color: isFailedOrCancelled
                                ? Colors.red.shade200
                                : isCompleted
                                    ? (isDarkMode ? Colors.white70 : Colors.black54)
                                    : (isDarkMode ? Colors.white54 : Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
