import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/onboarding/onboarding_screen.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';

class OnBoardHelper extends ConsumerWidget {
  final String boardTitle;
  final String boardImage;
  final String boardDescription;

  const OnBoardHelper({
    super.key,
    required this.boardImage,
    required this.boardTitle,
    required this.boardDescription,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(boardImage),
          ),
        ),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
              child: Column(
                children: [
                  Text(
                    boardTitle,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    boardDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(pageIndexProvider.notifier).nextPage(context);
                    },
                    child: const Text(
                      'ALLEZ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
