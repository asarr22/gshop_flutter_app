import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

final tabIndexProvider = StateProvider<int>((ref) => 0);

class CustomOrderTabBar extends ConsumerWidget {
  const CustomOrderTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(tabIndexProvider);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: isDarkMode ? ColorPalette.containerDark : ColorPalette.containerLight,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ongoing tab
            _buildTab(
              context: context,
              ref: ref,
              index: 0,
              text: TextValue.onGoing,
              isSelected: selectedIndex == 0,
            ),
            // Completed tab
            _buildTab(
              context: context,
              ref: ref,
              index: 1,
              text: TextValue.completed,
              isSelected: selectedIndex == 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required WidgetRef ref,
    required int index,
    required String text,
    required bool isSelected,
  }) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: InkWell(
        onTap: () => ref.read(tabIndexProvider.notifier).state = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          decoration: isSelected
              ? BoxDecoration(
                  color: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight,
                  borderRadius: BorderRadius.circular(15.0),
                )
              : null,
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : isDarkMode
                          ? Colors.white
                          : Colors.black,
                ),
          ),
        ),
      ),
    );
  }
}
