import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/shell/controllers/appshell_controllers.dart';
import 'package:gshopp_flutter/features/shell/screens/favori_page.dart';
import 'package:gshopp_flutter/features/shell/screens/home_page.dart';
import 'package:gshopp_flutter/features/shell/screens/profile_page.dart';
import 'package:gshopp_flutter/features/subviews/category_page/category_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
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
    final List<IconData> shellPagesIcon = [
      Iconsax.home,
      Iconsax.category,
      Iconsax.heart,
      Iconsax.user,
    ];

    //The widget
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Material(
          borderRadius: BorderRadius.circular(100),
          elevation: 12,
          color: isDarkMode ? ColorPalette.navBarDark : ColorPalette.navBarLight,
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 250,
              maxWidth: 340,
            ),
            height: 70,
            decoration: BoxDecoration(
              color: isDarkMode ? ColorPalette.navBarDark : ColorPalette.navBarLight,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  shellPages.length,
                  (index) => GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      ref.read(pageIndexProvider.notifier).sendToIndex(index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange.withOpacity(0.1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            shellPagesIcon[index],
                            color: pageIndex == index
                                ? Colors.orange
                                : isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          if (pageIndex == index) ...{
                            const SizedBox(height: 2),
                            Container(
                              height: 4,
                              width: 4,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          },
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
