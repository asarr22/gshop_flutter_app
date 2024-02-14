import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';

// Define a provider for managing the countdown state
final countdownProvider = StateNotifierProvider.autoDispose<CountdownNotifier, Duration>((ref) {
  // Initialize your CountdownNotifier here
  return CountdownNotifier();
});

// StateNotifier that holds the countdown logic
class CountdownNotifier extends StateNotifier<Duration> {
  Timer? _timer;
  DateTime? targetDate;

  CountdownNotifier() : super(Duration.zero) {
    // Initialize your targetDate and start the timer here
  }

  void startTimer(String dateString) {
    targetDate = Formatter.getDateFromString(dateString);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      if (targetDate != null) {
        final countdownDuration = targetDate!.difference(now);
        if (countdownDuration.isNegative) {
          // Handle countdown end
          state = Duration.zero;
          _timer?.cancel();
          onCountdownEnd();
        } else {
          state = countdownDuration; // Update state with new countdown value
        }
      }
    });
  }

  void onCountdownEnd() {
    // Use GetX navigation to close the current page
    Get.back();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Refactor your CountdownWidget to consume the countdownProvider
class CountdownWidget extends ConsumerWidget {
  final String dateString;

  const CountdownWidget({super.key, required this.dateString});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // Listen to the countdownProvider
    final countdown = ref.watch(countdownProvider);

    // You may call startTimer here or in an appropriate lifecycle method
    // Ensure you manage the lifecycle appropriately to avoid memory leaks or multiple timers
    ref.read(countdownProvider.notifier).startTimer(dateString);

    return SizedBox(
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          timeBox("D", countdown.inDays, isDarkMode),
          timeBox("H", countdown.inHours % 24, isDarkMode),
          timeBox("M", countdown.inMinutes % 60, isDarkMode),
          timeBox("S", countdown.inSeconds % 60, isDarkMode),
        ],
      ),
    );
  }

  Widget timeBox(String label, int value, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      width: 20.0,
      decoration: BoxDecoration(
        color: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 8),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
