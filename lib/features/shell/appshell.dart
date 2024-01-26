import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gshopp_flutter/features/shell/controllers/appshell_controllers.dart';
import 'package:gshopp_flutter/features/shell/screens/favori_page.dart';
import 'package:gshopp_flutter/features/shell/screens/home_page.dart';
import 'package:gshopp_flutter/features/shell/screens/profile_page.dart';
import 'package:gshopp_flutter/features/subviews/category_page/category_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

final pageIndexProvider = StateNotifierProvider<AppShellController, int>((ref) => AppShellController());

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    //State Notifier
    final pageIndex = ref.watch(pageIndexProvider);
    // Tabbed Page List
    final List<Widget> shellPages = [
      const HomePage(),
      const CategoryPage(),
      const FavoritePage(),
      const ProfilePage(),
    ];

    //The widget
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 200, // minimum width
          maxWidth: 350, // maximum width
        ),
        child: Material(
          elevation: 20,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: isDarkMode ? const Color.fromARGB(255, 111, 96, 72) : const Color(0xFFFFF6E7),
            ),
            child: GNav(
                tabMargin: const EdgeInsets.symmetric(vertical: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                mainAxisAlignment: MainAxisAlignment.center,
                color: isDarkMode ? ColorPalette.onPrimaryDark : ColorPalette.onPrimaryLight,
                activeColor: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight,
                tabBackgroundColor: Colors.orange.withOpacity(0.1),
                onTabChange: (value) => ref.read(pageIndexProvider.notifier).sendToIndex(value),
                tabs: const [
                  GButton(
                    icon: Iconsax.home,
                    text: TextValue.homeTab,
                  ),
                  GButton(
                    icon: Iconsax.category,
                    text: TextValue.categorieTab,
                  ),
                  GButton(
                    icon: Iconsax.heart,
                    text: TextValue.favoriteTab,
                  ),
                  GButton(
                    icon: Iconsax.user,
                    text: TextValue.accountTab,
                  ),
                ]),
          ),
        ),
      ),
      body: IndexedStack(
        index: pageIndex,
        children: shellPages,
      ),
    );
  }
}
