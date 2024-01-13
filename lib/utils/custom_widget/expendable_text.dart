import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/state/expendable_text_controller.dart';

final expandControllerProvider = StateNotifierProvider<ExpandController, bool>((ref) => ExpandController());

class ExpandableText extends ConsumerWidget {
  final String text;
  const ExpandableText({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(expandControllerProvider);
    return GestureDetector(
      onTap: () => ref.read(expandControllerProvider.notifier).toggle(),
      child: Column(
        children: [
          text.isNotEmpty
              ? Text(
                  isExpanded ? text : ('${text.substring(0, 100)}... Read more'),
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.justify,
                  maxLines: isExpanded ? null : 3,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
