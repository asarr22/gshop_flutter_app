import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/user_controller.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class UserGreetingsBanner extends ConsumerWidget {
  const UserGreetingsBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerProvider);
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                style: const TextStyle(
                        color: ColorPalette.primary, fontSize: 16, fontFamily: 'Freight', fontWeight: FontWeight.w700)
                    .apply(fontWeightDelta: 2),
              )
            ],
          ),
          RoundedImage(
            borderRadius: 100,
            isNetworkImage: true,
            height: 40,
            width: 40,
            imgUrl: user.profilePicture.isNotEmpty
                ? user.profilePicture
                : "https://cdn-icons-png.flaticon.com/512/147/147129.png",
          ),
        ],
      ),
    );
  }
}
