import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class CategoryItem {
  final String title;
  final String image;
  final int id;
  CategoryItem({
    required this.title,
    required this.image,
    required this.id,
  });
}

class CategoryModel {
  List<CategoryItem> categoryMenuItems = [
    CategoryItem(title: TextValue.pc, image: ImagesValue.laptopIcon, id: 1),
    CategoryItem(
        title: TextValue.phone, image: ImagesValue.smartphoneIcon, id: 2),
    CategoryItem(title: TextValue.watches, image: ImagesValue.watchIcon, id: 3),
    CategoryItem(
        title: TextValue.headphone, image: ImagesValue.airpodIcon, id: 4),
    CategoryItem(
        title: TextValue.accessories, image: ImagesValue.cableIcon, id: 5),
    CategoryItem(
        title: TextValue.monitor, image: ImagesValue.monitorIcon, id: 6)
  ];

  CategoryItem getItemAt(int index) {
    if (index >= 0 && index < categoryMenuItems.length) {
      return categoryMenuItems[index];
    } else {
      throw ArgumentError('Invalid index: $index');
    }
  }

  int get count => categoryMenuItems.length;
}
