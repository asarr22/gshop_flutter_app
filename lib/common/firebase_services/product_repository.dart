import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/format_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/platform_exceptions.dart';

class ProductRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch Popular Products
  Future<List<Product>> getPopularProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('isPopular', isEqualTo: true).get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Fetch a Single Product and Listen to Changes

  Stream<Product> getProductByID(String productID) {
    DocumentReference reference = _db.collection('Products').doc(productID);
    return reference
        .snapshots()
        .map((snapshot) => Product.fromSnapshot(snapshot as DocumentSnapshot<Map<String, dynamic>>));
  }

  Future<List<Product>> getNewProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('isPopular', isEqualTo: true).get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
