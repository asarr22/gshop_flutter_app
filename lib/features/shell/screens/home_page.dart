import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/promo_event_controller.dart';
import 'package:gshopp_flutter/common/controllers/user_cart_controller.dart';
import 'package:gshopp_flutter/common/models/app/event_model.dart';
import 'package:gshopp_flutter/features/shell/screens/cart_page.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/category_menu.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/flash_item_section.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/new_arrival_product_section.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/popular_item_section.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/promo_carousel.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/timer_widget.dart';
import 'package:gshopp_flutter/features/subviews/search_page/search_page.dart';
import 'package:gshopp_flutter/utils/animations/custom_fade_animation.dart';
import 'package:gshopp_flutter/utils/styles/texts/section_header.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/user_greetings_banner.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/shell/widgets/search_container.dart';
import 'package:gshopp_flutter/features/subviews/category_page/category_page.dart';
import 'package:gshopp_flutter/features/subviews/global_products/global_product_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    final cartCount = ref.watch(userCartControllerProvider).length;
    final event = ref.watch(promoEventControllerProvider).firstWhere(
          (e) => e.id == '0',
          orElse: () => PromoEventModel.empty(), // Handle the case where no event matches.
        );
    super.build(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text(TextValue.appName,
              style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'Freight',
                  fontSize: 30,
                  fontWeight: FontWeight.w900)),
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: ColorPalette.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Iconsax.notification,
                        color: isDarkMode ? Colors.white : Colors.black,
                      )),
                  color: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight,
                  iconSize: 25,
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: RoundedContainer(
                      height: 20,
                      width: 20,
                      radius: 100,
                      backgroundColor: ColorPalette.primary,
                      child: Center(
                        child: Text(
                          cartCount.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ))
              ],
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(() => const CartPage(), transition: Transition.downToUp);
                  },
                  icon: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: ColorPalette.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Iconsax.shopping_cart,
                        color: isDarkMode ? Colors.white : Colors.black,
                      )),
                  color: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight,
                  iconSize: 25,
                ),
                cartCount < 1
                    ? const SizedBox()
                    : Positioned(
                        bottom: 0,
                        right: 0,
                        child: RoundedContainer(
                          height: 20,
                          width: 20,
                          radius: 100,
                          backgroundColor: ColorPalette.primary,
                          child: Center(
                            child: Text(
                              cartCount.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ))
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Greeting Banner
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: SizesValue.padding),
                child: FadeTranslateAnimation(
                  delay: 100,
                  child: UserGreetingsBanner(),
                ),
              ),
              const SizedBox(height: 20),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
                child: FadeTranslateAnimation(
                  delay: 200,
                  child: SearchContainer(
                    onTap: () {
                      Get.to(() => const SearchPage());
                    },
                  ),
                ),
              ),
              const SizedBox(height: SizesValue.spaceBtwSections * 1.5),

              // Banners
              const FadeTranslateAnimation(
                delay: 300,
                child: PromoCarousel(),
              ),
              const SizedBox(height: SizesValue.spaceBtwSections * 1.5),

              // Categories
              SectionHeader(
                title: TextValue.categories,
                onTap: () => Get.to(() => const CategoryPage()),
              ),
              const SizedBox(height: SizesValue.spaceBtwItems),
              const FadeTranslateAnimation(
                delay: 400,
                child: HomeCategoryList(),
              ),

              // Flash Sale
              const SizedBox(height: SizesValue.spaceBtwSections),
              SectionHeader(
                height: 40,
                title: TextValue.flashSale,
                action: Row(
                  children: [
                    CountdownWidget(
                      dateString: event.endDate,
                      goBackWhenEventEnd: false,
                    ),
                    Icon(
                      Iconsax.arrow_right_3,
                      size: 15,
                      color: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight,
                    )
                  ],
                ),
                onTap: () => Get.to(
                  () => GlobalProductPage(
                    pageTitle: TextValue.popular,
                    query:
                        FirebaseFirestore.instance.collection('Products').where('promoCode', isEqualTo: '0').limit(2),
                  ),
                ),
              ),
              const SizedBox(height: SizesValue.spaceBtwItems),
              const FlashSaleItemSection(),
              const SizedBox(height: SizesValue.spaceBtwSections),

              //Popular Product
              SectionHeader(
                title: TextValue.popular,
                onTap: () => Get.to(
                  () => GlobalProductPage(
                    pageTitle: TextValue.popular,
                    query: FirebaseFirestore.instance.collection('Products').where('isPopular', isEqualTo: true),
                  ),
                ),
              ),
              const SizedBox(height: SizesValue.spaceBtwItems),

              const PopularProductSection(),
              const SizedBox(height: 20),

              // Individual Promotion
              const Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: RoundedImage(
                    imgUrl: ImagesValue.promo4,
                    width: double.infinity,
                    height: 190,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // New Arrival Section
              SectionHeader(
                title: TextValue.newArrival,
                onTap: () => Get.to(
                  () => GlobalProductPage(
                    pageTitle: TextValue.newArrival,
                    query: FirebaseFirestore.instance.collection('Products').where('isNew', isEqualTo: true),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              const NewArriavalProductSection(),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
