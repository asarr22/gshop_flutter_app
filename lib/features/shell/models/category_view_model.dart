import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class CategoryItem {
  final String title;
  final String image;
  String codeName;
  final int id;
  CategoryItem({
    required this.title,
    required this.image,
    required this.codeName,
    required this.id,
  });
}

class CategoryModel {
  List<CategoryItem> categoryMenuItems = [
    CategoryItem(title: TextValue.pc, image: ImagesValue.laptopIcon, id: 1, codeName: 'pc'),
    CategoryItem(title: TextValue.phone, image: ImagesValue.smartphoneIcon, id: 2, codeName: 'phone'),
    CategoryItem(title: TextValue.watches, image: ImagesValue.watchIcon, id: 3, codeName: 'watch'),
    CategoryItem(title: TextValue.headphone, image: ImagesValue.airpodIcon, id: 4, codeName: 'headphone'),
    CategoryItem(title: TextValue.accessories, image: ImagesValue.cableIcon, id: 5, codeName: 'accessories'),
    CategoryItem(title: TextValue.monitor, image: ImagesValue.monitorIcon, id: 6, codeName: 'monitor'),
    CategoryItem(title: TextValue.appliance, image: ImagesValue.applianceIcon, id: 7, codeName: 'appliance'),
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
