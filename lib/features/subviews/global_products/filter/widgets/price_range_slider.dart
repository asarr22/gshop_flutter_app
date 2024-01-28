import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/styles/borderless_text_field_decoration.dart';

final filterPriceRangeProvider = StateNotifierProvider.autoDispose<RangeNotifier, RangeValues>((ref) {
  return RangeNotifier();
});

class RangeNotifier extends StateNotifier<RangeValues> {
  RangeNotifier() : super(const RangeValues(100, 5000000));

  void updateRange(RangeValues newRange) {
    state = newRange;
  }

  void resetRange() {
    state = const RangeValues(100, 5000000);
  }
}

class PriceRangeSlider extends ConsumerWidget {
  const PriceRangeSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    RangeValues range = ref.watch(filterPriceRangeProvider);
    TextEditingController startTextController = TextEditingController(text: range.start.round().toString());
    TextEditingController endTextController = TextEditingController(text: range.end.round().toString());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    TextValue.from,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  TextFormField(
                    controller: startTextController,
                    decoration: TextFieldStyles.borderless(isDarkMode),
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      final newStart = double.tryParse(value) ?? range.start;
                      ref.read(filterPriceRangeProvider.notifier).updateRange(RangeValues(newStart, range.end));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    TextValue.to,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  TextFormField(
                    controller: endTextController,
                    decoration: TextFieldStyles.borderless(isDarkMode),
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      final newEnd = double.tryParse(value) ?? range.end;
                      ref.read(filterPriceRangeProvider.notifier).updateRange(RangeValues(range.start, newEnd));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2.0, // Sets the track height of the slider.
          ),
          child: RangeSlider(
            values: range,
            min: 0,
            max: 5000000, // Adjust max value accordingly
            divisions: 10000,
            onChanged: (newRange) {
              ref.read(filterPriceRangeProvider.notifier).updateRange(newRange);
              startTextController.text = newRange.start.round().toString();
              endTextController.text = newRange.end.round().toString();
            },
          ),
        ),
      ],
    );
  }
}
