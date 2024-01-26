import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class CategoryItem {
  final String title;
  final String image;
  final String codeName;
  final int id;
  final List<Map<String, String>> subCategories;

  CategoryItem({
    required this.title,
    required this.image,
    required this.codeName,
    required this.id,
    required this.subCategories,
  });
}

class CategoryModel {
  List<CategoryItem> categoryMenuItems = [
    CategoryItem(
      title: TextValue.pc,
      image: ImagesValue.laptopIcon,
      id: 1,
      codeName: 'pc',
      subCategories: [
        {'laptop': TextValue.laptop},
        {'desktop': TextValue.desktop},
        {'all-in-one': TextValue.allInOne},
        {'all': TextValue.all}
      ],
    ),
    CategoryItem(
      title: TextValue.phone,
      image: ImagesValue.smartphoneIcon,
      id: 2,
      codeName: 'phone',
      subCategories: [
        {'smartphone': TextValue.smartphone},
        {'tablet': TextValue.tablet},
        {'phone': TextValue.phone},
        {'all': TextValue.all}
      ],
    ),
    CategoryItem(
      title: TextValue.gadget,
      image: ImagesValue.gadgetIcon,
      id: 3,
      codeName: 'gadget',
      subCategories: [
        {'smartwatch': TextValue.smartwatch},
        {'earbuds': TextValue.earbuds},
        {'earphone': TextValue.earphone},
        {'powerbank': TextValue.powerbank},
        {'gadget': TextValue.gadget},
        {'all': TextValue.all}
      ],
    ),
    CategoryItem(
      title: TextValue.tv,
      image: ImagesValue.tvIcon,
      id: 4,
      codeName: 'tv',
      subCategories: [
        {'tv': TextValue.tv},
        {'tv-box': TextValue.tvBox},
        {'projector': TextValue.projector},
        {'all': TextValue.all}
      ],
    ),
    CategoryItem(
      title: TextValue.monitor,
      image: ImagesValue.monitorIcon,
      id: 5,
      codeName: 'monitor',
      subCategories: [],
    ),
    CategoryItem(
      title: TextValue.appliance,
      image: ImagesValue.applianceIcon,
      id: 6,
      codeName: 'appliance',
      subCategories: [
        {'appliance': TextValue.appliance},
        {'all': TextValue.all}
      ],
    ),
    CategoryItem(
      title: TextValue.software,
      image: ImagesValue.softwareIcon,
      id: 7,
      codeName: 'software',
      subCategories: [
        {'operating-system': TextValue.operatingSystem},
        {'antivirus': TextValue.antivirus},
        {'software': TextValue.software},
        {'all': TextValue.all}
      ],
    ),
    CategoryItem(
      title: TextValue.accessories,
      image: ImagesValue.accessoriesIcon,
      id: 8,
      codeName: 'accessories',
      subCategories: [
        {'keyboard': TextValue.keyboard},
        {'mouse': TextValue.mouse},
        {'headphone': TextValue.headphone},
        {'webcam': TextValue.webcam},
        {'microphone': TextValue.microphone},
        {'cable': TextValue.cable},
        {'charger': TextValue.charger},
        {'adapter': TextValue.adapter},
        {'others': TextValue.others},
        {'all': TextValue.all}
      ],
    ),
  ];

  CategoryItem getItemAt(int index) {
    if (index >= 0 && index < categoryMenuItems.length) {
      return categoryMenuItems[index];
    } else {
      throw ArgumentError('Invalid index: $index');
    }
  }

  List<CategoryItem> get getAllItems => categoryMenuItems;

  int get count => categoryMenuItems.length;
}
