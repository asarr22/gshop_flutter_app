import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/repositories/promo_event_repository.dart';
import 'package:gshopp_flutter/common/models/app/event_model.dart';

class PromoEventController extends StateNotifier<List<PromoEventModel>> {
  final PromoEventRepository _promoEventRepository;

  PromoEventController(this._promoEventRepository) : super([]) {
    getPromoEvent();
  }

  Future<void> getPromoEvent() async {
    var promoEvent = await _promoEventRepository.getPromoEventData();
    state = promoEvent;
  }
}

final promoEventControllerProvider = StateNotifierProvider<PromoEventController, List<PromoEventModel>>(
    (ref) => PromoEventController(PromoEventRepository()));
