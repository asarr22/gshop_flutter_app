import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gshopp_flutter/common/controllers/user_controller.dart';
import 'package:gshopp_flutter/common/repositories/auth_services.dart';
import 'package:gshopp_flutter/features/authentication/screens/login_screen.dart';
import 'package:gshopp_flutter/features/shell/screens/profile.widgets/button_card.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/subviews/order_page/order_page.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/screens/address_list.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/screens/edit_account_info.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/screens/setting_page.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerProvider);
    final authService = ref.watch(firebaseAuthServiceProvider);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            TextValue.myProfile,
            style: Theme.of(context).textTheme.displayLarge,
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
                  // Profile Picture
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(100),
                      shadowColor: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primary,
                      child: RoundedImage(
                        borderRadius: 100,
                        isNetworkImage: true,
                        imgUrl: user.profilePicture.isNotEmpty
                            ? user.profilePicture
                            : "https://cdn-icons-png.flaticon.com/512/147/147129.png",
                      ),
                    ),
                  ),

                  // Name
                  const SizedBox(height: 10),
                  Text(
                    user.fullName,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 50),

                  // Personal Info Page
                  ButtonCardTile(
                    title: TextValue.personalInfo,
                    description: TextValue.personalInfoDescription,
                    onTap: () => Get.to(() => const EditAccountPage()),
                  ),
                  const SizedBox(height: 10),

                  // Order Page
                  ButtonCardTile(
                    title: TextValue.myOrders,
                    description: TextValue.myOrdersDescription,
                    onTap: () => Get.to(() => const OrderPage()),
                  ),
                  const SizedBox(height: 10),

                  // Address Page
                  ButtonCardTile(
                    title: TextValue.myAddresses,
                    description: TextValue.myOrdersDescription,
                    onTap: () {
                      Get.to(() => const AddressesScreen());
                    },
                  ),
                  const SizedBox(height: 10),

                  // Notification Page
                  const ButtonCardTile(title: TextValue.notifications, description: TextValue.notificationsDescription),
                  const SizedBox(height: 10),

                  // Settings Page
                  ButtonCardTile(
                    title: TextValue.settings,
                    description: TextValue.settingsDescription,
                    onTap: () => Get.to(() => const SettingPage()),
                  ),
                  const SizedBox(height: 50),

                  // Signout Button
                  ButtonCardTile(
                    implyDescription: false,
                    title: authService.authUser == null ? TextValue.signin : TextValue.signout,
                    onTap: () {
                      if (authService.authUser != null) {
                        authService.logout();
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
