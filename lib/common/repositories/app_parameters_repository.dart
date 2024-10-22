import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/address/shipping_model.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/format_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/platform_exceptions.dart';

final appRepositoryProvider = Provider<AppRepository>((ref) {
  return AppRepository();
});

class AppRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get Shippment data

  Future<List<City>> getShippmentData() async {
    try {
      final snapshot = await _db.collection('Cities').get();
      return snapshot.docs.map((doc) => City.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('FirebaseException: ${GFirebaseException(e.code).message}');
      }
      return [];
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    }
  }
}
