import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/app/event_model.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/format_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/platform_exceptions.dart';

final promoEventRepositoryProvider = Provider<PromoEventRepository>((ref) {
  return PromoEventRepository();
});

class PromoEventRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<PromoEventModel>> getPromoEventData() async {
    try {
      final snapshot = await _db.collection('PromoEvent').get();
      return snapshot.docs.map((doc) => PromoEventModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
  }
}
