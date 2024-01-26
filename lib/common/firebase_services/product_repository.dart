import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/subviews/model/ratings_model.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/format_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/platform_exceptions.dart';

class ProductRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch Popular Products
  Future<List<Product>> getPopularProducts(int limit) async {
    try {
      final snapshot = await _db.collection('Products').where('isPopular', isEqualTo: true).limit(limit).get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
  }

  // Fetch New Arrival Products
  Future<List<Product>> getNewArrivalProducts(int limit) async {
    try {
      final snapshot = await _db.collection('Products').where('isNew', isEqualTo: true).limit(limit).get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
  }

  // Fetch Product By Single Filter
  Future<List<Product>> getProductbySingleFilter(int limit, Map<String, dynamic> filter) async {
    try {
      final snapshot =
          await _db.collection('Products').where(filter.keys.first, isEqualTo: filter.values.first).limit(limit).get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
  }

  // Fetch Product By Custom Query
  Future<List<Product>> getProductbyCustomQuery(int limit, Query<Map<String, dynamic>> query) async {
    try {
      final snapshot = await query.limit(limit).get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
  }

  // Fetch Product By Double Filter
  Future<List<Product>> getProductbyDoubleFilter(
      int limit, Map<String, dynamic> filter, Map<String, dynamic> filter2) async {
    try {
      final snapshot =
          await _db.collection('Products').where(filter.keys.first, isEqualTo: filter.values.first).limit(limit).get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
  }

  // Fetch a Single Product and Listen to Changes

  Stream<Product> getProductByID(String productID) {
    try {
      DocumentReference reference = _db.collection('Products').doc(productID);
      return reference
          .snapshots()
          .map((snapshot) => Product.fromSnapshot(snapshot as DocumentSnapshot<Map<String, dynamic>>));
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

// Fetch Product Reviews
  Future<List<RatingModel>> getProductReviews(String productID) async {
    try {
      if (productID == "") {
        return List.empty();
      }
      final snapshot = await _db.collection('Products').doc(productID).collection('Reviews').get();

      //Set users profile image for each review
      final data = snapshot.docs.map((doc) => RatingModel.fromSnapshot(doc)).toList();
      for (var element in data) {
        element.userImage = await getUserProfileImage(element.userID);
      }
      return data;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

  // Add Product Review
  Future<void> addProductReview(String productID, RatingModel ratingModel) async {
    try {
      // Get Product Rating
      final productSnapshot = await _db.collection('Products').doc(productID).get();
      final product = Product.fromSnapshot(productSnapshot);

      // Calculate New Rating
      double? newRating = 0;

      if (product.rating == 0) {
        newRating = ratingModel.rating.toDouble();
      } else {
        newRating = (product.rating + ratingModel.rating) / 2;
      }

      // Add the new Review
      await _db.collection('Products').doc(productID).collection('Reviews').doc().set(ratingModel.toJson());

      // Update Product Rating
      await _db.collection('Products').doc(productID).update({'rating': newRating});
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

  // Get User Profile Image Using User ID

  Future<String> getUserProfileImage(String userID) async {
    try {
      final snapshot = await _db.collection('Users').doc(userID).get();
      return snapshot.get('ProfilePicture');
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
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
      throw 'Error : ${e.toString()}';
    }
  }
}
