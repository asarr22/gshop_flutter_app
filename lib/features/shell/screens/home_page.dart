import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/category_menu.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/popular_item_section.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/promo_carousel.dart';
import 'package:gshopp_flutter/common/widgets/texts/section_header.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/user_greetings_banner.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/shell/widgets/search_container.dart';
import 'package:gshopp_flutter/features/subviews/category_page/category_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

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

    super.build(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Align(
            alignment: Alignment.center,
            child: Text(TextValue.appName,
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black, fontFamily: 'Freight', fontSize: 30, fontWeight: FontWeight.w900)),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: ColorPalette.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.menu),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
              color: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight,
              iconSize: 35,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Greeting Banner
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: SizesValue.padding),
                child: UserGreetingsBanner(),
              ),

              const SizedBox(
                height: 20,
              ),

              // Search Bar
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: SizesValue.padding),
                child: SearchContainer(),
              ),

              const SizedBox(height: 20),

              const PromoCarousel(
                banners: [
                  ImagesValue.promo1,
                  ImagesValue.promo2,
                  ImagesValue.promo3,
                ],
              ),
              const SizedBox(height: 20),

              //Categories

              SectionHeader(
                title: TextValue.categories,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategoryPage())),
              ),
              const SizedBox(height: 10),
              const HomeCategoryList(),

              const SizedBox(height: 20),
              //Popular Profuct
              const SectionHeader(title: TextValue.popular),
              const SizedBox(height: 10),

              const PopularProductSection(),
              const SizedBox(height: 40),

              // Individual Promotion
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RoundedImage(
                  imgUrl: ImagesValue.promo4,
                  width: double.infinity,
                  height: 190,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
              const SizedBox(height: 20),
              //Popular Profuct
              const SectionHeader(title: TextValue.newArrival),
              const SizedBox(height: 10),

              const PopularProductSection(),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
