// ignore_for_file: unused_element

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/category/subcategory_list.dart';
import 'package:gshopp_flutter/features/shell/models/category_view_model.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class SubcategoryState {
  final List<Subcategory> subcategories;
  final Subcategory? selectedSubcategory;

  SubcategoryState({required this.subcategories, this.selectedSubcategory});

  // Method to update the selected subcategory
  SubcategoryState selectSubcategory(Subcategory subcategory) {
    return SubcategoryState(subcategories: subcategories, selectedSubcategory: subcategory);
  }
}

class SubcategoryNotifier extends StateNotifier<SubcategoryState> {
  SubcategoryNotifier(List<Subcategory> initialSubcategories)
      : super(SubcategoryState(subcategories: initialSubcategories));

  void selectSubcategory(Subcategory subcategory) {
    state = state.selectSubcategory(subcategory);
  }
}

final subcategoryProvider = StateNotifierProvider.autoDispose<SubcategoryNotifier, SubcategoryState>((ref) {
  // Provide the initial list of subcategories
  // Method to get the list of subcategories from the category model
  List<Subcategory> getCategoryListFromCategoryModel() {
    CategoryModel categoryModel = CategoryModel();
    final categoryList = categoryModel.getAllItems;
    List<Subcategory> builtList = [];
    for (var element in categoryList) {
      builtList.add(Subcategory(id: element.id, name: element.title, codeName: element.codeName));
    }
    return builtList;
  }

  List<Subcategory> initialSubcategories(String type) {
    switch (type) {
      default:
        return getCategoryListFromCategoryModel();
    }
  }

  return SubcategoryNotifier([
    Subcategory(id: 0, name: 'Tout', codeName: 'all'),
    Subcategory(
      id: 1,
      codeName: 'phone',
      name: TextValue.phone,
    ),
    Subcategory(
      id: 2,
      codeName: 'pc',
      name: TextValue.pc,
    ),
    Subcategory(
      id: 3,
      codeName: 'watch',
      name: TextValue.watches,
    ),
    Subcategory(
      id: 4,
      codeName: 'headphone',
      name: TextValue.headphone,
    ),
  ]);
});
