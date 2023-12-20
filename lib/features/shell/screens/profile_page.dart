import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/login.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/user_greetings_banner.dart';
import 'package:gshopp_flutter/features/shell/screens/profile.widgets/button_card.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/screens/edit_account_info.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              TextValue.profile,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 100,
                    width: 100,
                    child: RoundedImage(
                      borderRadius: 100,
                      isNetworkImage: true,
                      imgUrl: "https://cdn-icons-png.flaticon.com/512/147/147129.png",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.fullName,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 50),
                  ButtonCardTile(
                    title: TextValue.personalInfo,
                    description: TextValue.personalInfoDescription,
                    onTap: () => Get.to(() => const EditAccountPage()),
                  ),
                  const SizedBox(height: 10),
                  const ButtonCardTile(title: TextValue.myOrders, description: TextValue.myOrdersDescription),
                  const SizedBox(height: 10),
                  const ButtonCardTile(title: TextValue.notifications, description: TextValue.notificationsDescription),
                  const SizedBox(height: 10),
                  const ButtonCardTile(title: TextValue.settings, description: TextValue.settingsDescription),
                  const SizedBox(height: 50),
                  ButtonCardTile(
                    implyDescription: false,
                    title: FirebaseAuthService.instance.authUser == null ? TextValue.signin : TextValue.signout,
                    onTap: () {
                      if (FirebaseAuthService.instance.authUser != null) {
                        FirebaseAuthService.instance.logout();
                      } else {
                        Get.to(() => const LoginPage());
                      }
                    },
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
