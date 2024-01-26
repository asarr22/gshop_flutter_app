import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class CategoryItem {
  final String title;
  final String image;
  final String codeName;
  final int id;
  final List<String> subCategories;

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
      subCategories: ['laptop', 'desktop'],
    ),
    CategoryItem(
      title: TextValue.phone,
      image: ImagesValue.smartphoneIcon,
      id: 2,
      codeName: 'phone',
      subCategories: ['phone', 'tablet'],
    ),
    CategoryItem(
      title: TextValue.gadget,
      image: ImagesValue.gadgetIcon,
      id: 3,
      codeName: 'gadget',
      subCategories: ['gadget'],
    ),
    CategoryItem(
        title: TextValue.office,
        image: ImagesValue.officeIcon,
        id: 4,
        codeName: 'office',
        subCategories: ['office', 'office accessories']),
    CategoryItem(
      title: TextValue.tv,
      image: ImagesValue.tvIcon,
      id: 5,
      codeName: 'tv',
      subCategories: ['tv'],
    ),
    CategoryItem(
        title: TextValue.monitor,
        image: ImagesValue.monitorIcon,
        id: 6,
        codeName: 'monitor',
        subCategories: ['monitor']),
    CategoryItem(
        title: TextValue.appliance,
        image: ImagesValue.applianceIcon,
        id: 7,
        codeName: 'appliance',
        subCategories: ['appliance']),
    CategoryItem(
        title: TextValue.software,
        image: ImagesValue.softwareIcon,
        id: 8,
        codeName: 'software',
        subCategories: ['software']),
    CategoryItem(
        title: TextValue.accessories,
        image: ImagesValue.accessoriesIcon,
        id: 9,
        codeName: 'accessories',
        subCategories: ['accessories']),
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
