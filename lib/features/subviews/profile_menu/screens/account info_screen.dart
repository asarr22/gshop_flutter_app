import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gshopp_flutter/common/controllers/user_controller.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:gshopp_flutter/utils/widgets/section_header.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/subviews/change_birthday_date.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/subviews/change_password.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/subviews/change_phone_number.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/subviews/edit_name.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/subviews/gender_selection_popup.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/widgets/edit_profile_menu.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

class AccountInfoPage extends ConsumerWidget {
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerProvider);
    final userController = ref.read(userControllerProvider.notifier);
    return Scaffold(
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
                  RoundedImage(
                    borderRadius: 100,
                    isNetworkImage: true,
                    imgUrl: user.profilePicture.isNotEmpty
                        ? user.profilePicture
                        : "https://cdn-icons-png.flaticon.com/512/147/147129.png",
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        userController.uploadProfileImage(ref);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(color: ColorPalette.primary, borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
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

            // Email
            PEditProfileMenu(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: user.email));
              },
              title: TextValue.email,
              value: user.email,
              icon: Iconsax.copy,
            ),

            if (!GHelper.isSignedUpWithGoogle())
              // Password
              PEditProfileMenu(
                  onPressed: () => Get.to(() => const ChangePasswordScreen()),
                  title: TextValue.password,
                  value: '●●●●●●●'),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            /// Personal Info
            const SectionHeader(
              padding: EdgeInsets.zero,
              title: TextValue.personalInfo,
              showActionButton: false,
            ),
            const SizedBox(height: 10),

            // Full Name
            PEditProfileMenu(
                onPressed: () => Get.to(() => const EditNameScreen()), title: TextValue.name, value: user.fullName),

            // Phone Number
            PEditProfileMenu(
                onPressed: () {
                  Get.to(() => const ChangePhoneNumberScreen());
                },
                title: TextValue.phoneNo,
                value: user.phoneNumber),

            // Gender
            PEditProfileMenu(
                onPressed: () {
                  GenderSelect.showPicker(context, ref);
                },
                title: TextValue.gender,
                value: user.gender.isEmpty ? TextValue.undefined : user.gender),

            // Birthday
            PEditProfileMenu(
                onPressed: () {
                  BirthDateSelection.showPicker(context, ref);
                },
                title: TextValue.dateOFBirth,
                value: user.birthday.isEmpty ? TextValue.undefined : user.birthday),
            const SizedBox(height: 50),
          ],
        ),
      )),
    );
  }
}
