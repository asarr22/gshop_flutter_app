import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewReviewControllerSlider extends StateNotifier<double> {
  AddNewReviewControllerSlider() : super(4);

  void setSliderValue(double value) {
    state = value;
  }
}

final addNewReviewControllerSliderProvider =
    StateNotifierProvider<AddNewReviewControllerSlider, double>((ref) => AddNewReviewControllerSlider());

class AddNewReviewTextController extends StateNotifier<TextEditingController> {
  AddNewReviewTextController() : super(TextEditingController());
}

final addNewReviewTextControllerProvider =
    StateNotifierProvider.autoDispose<AddNewReviewTextController, TextEditingController>(
        (ref) => AddNewReviewTextController());
