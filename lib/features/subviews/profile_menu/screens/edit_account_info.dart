import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gshopp_flutter/common/widgets/texts/section_header.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/user_greetings_banner.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/subviews/edit_name.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/widgets/edit_profile_menu.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

class EditAccountPage extends ConsumerWidget {
  const EditAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_24),
            onPressed: () => Get.back(),
          ),
          title: Text(
            TextValue.accountInfo,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                width: 100,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const RoundedImage(
                      borderRadius: 100,
                      isNetworkImage: true,
                      imgUrl: "https://cdn-icons-png.flaticon.com/512/147/147129.png",
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(color: ColorPalette.primary, borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              const SectionHeader(
                padding: EdgeInsets.zero,
                title: TextValue.myAccount,
                showActionButton: false,
              ),
              PEditProfileMenu(onPressed: () {}, title: TextValue.username, value: user.username),
              PEditProfileMenu(onPressed: () {}, title: TextValue.email, value: user.email),
              PEditProfileMenu(onPressed: () {}, title: TextValue.password, value: '●●●●●●●'),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              const SectionHeader(
                padding: EdgeInsets.zero,
                title: TextValue.personalInfo,
                showActionButton: false,
              ),
              const SizedBox(height: 10),
              PEditProfileMenu(onPressed: () => Get.to(() => const EditNameScreen()), title: TextValue.name, value: user.fullName),
              PEditProfileMenu(onPressed: () {}, title: TextValue.phoneNo, value: user.phoneNumber),
              PEditProfileMenu(onPressed: () {}, title: TextValue.gender, value: 'Homme'),
              PEditProfileMenu(onPressed: () {}, title: TextValue.address, value: 'Liberté 5'),
              PEditProfileMenu(onPressed: () {}, title: TextValue.dateOFBirth, value: '10 Oct 1999'),
              const SizedBox(height: 50),
            ],
          ),
        )),
      ),
    );
  }
}
