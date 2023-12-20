// Declare your providers in a separate file, e.g., providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/state/selected_variant_controller.dart';

final variantSelectionProvider =
    StateNotifierProvider<SelectedVariantController, Variant>(
        (ref) => SelectedVariantController());
