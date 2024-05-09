import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(isDarkMode ? ImagesValue.appLogoDark : ImagesValue.appLogoLight),
          height: 120,
        ),
        Text(
          TextValue.loginTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          TextValue.loginSubtite,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}

class LoginPageFooter extends StatelessWidget {
  const LoginPageFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(ImagesValue.googleLogo),
              height: 25,
              width: 25,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(ImagesValue.facebookLogo),
              height: 25,
              width: 25,
            ),
          ),
        )
      ],
    );
  }
}
