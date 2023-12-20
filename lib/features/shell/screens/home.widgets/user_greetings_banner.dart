import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/features/authentication/models/user_Model.dart';
import 'package:gshopp_flutter/features/personalization/controllers/user_controller.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

final userControllerProvider = StateNotifierProvider<UserController, UserModel>((ref) {
  return UserController(ref.watch(userRepositoryProvider));
});

class UserGreetingsBanner extends ConsumerWidget {
  const UserGreetingsBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextValue.greetings,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              user.fullName,
              style: const TextStyle(color: ColorPalette.primary, fontSize: 16, fontFamily: 'Freight', fontWeight: FontWeight.w700)
                  .apply(fontWeightDelta: 2),
            )
          ],
        ),
        const CircleAvatar(
          backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/147/147129.png'),
        )
      ],
    );
  }
}
