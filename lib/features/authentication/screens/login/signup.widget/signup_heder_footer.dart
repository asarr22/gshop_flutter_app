import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({
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

class SignupWithProvider extends StatelessWidget {
  const SignupWithProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Flexible(
          child: Divider(color: Colors.grey),
        ),
        Text(
          TextValue.orSignInwith,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const Flexible(
          child: Divider(color: Colors.grey),
        ),
      ],
    );
  }
}

class SignupHeader extends StatelessWidget {
  const SignupHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        TextValue.signupTitle,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}
