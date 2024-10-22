import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/product_controller.dart';
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
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    }
  }

  // Fetch New Arrival Products
  Future<List<Product>> getNewArrivalProducts(int limit) async {
    try {
      final snapshot = await _db.collection('Products').where('isNew', isEqualTo: true).limit(limit).get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    }
  }

  // Fetch Product By Single Filter
  Future<List<Product>> getProductbySingleFilter(int limit, Map<String, dynamic> filter) async {
    try {
      final snapshot =
          await _db.collection('Products').where(filter.keys.first, isEqualTo: filter.values.first).limit(limit).get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    }
  }

  // Fetch Product By Custom Query
  Future<QueryResult> getProductbyCustomQuery(int limit, Query<Map<String, dynamic>> query,
      {DocumentSnapshot? startAfter}) async {
    try {
      Query modifiedQuery = query.limit(limit);
      if (startAfter != null) {
        modifiedQuery = modifiedQuery.startAfterDocument(startAfter);
      }
      final snapshot = await modifiedQuery.get();
      final products =
          snapshot.docs.map((doc) => Product.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
      final bool hasMore = products.length == limit; // Assuming if products count < limit, there are no more products
      final DocumentSnapshot? lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

      return QueryResult(products, lastDocument, hasMore);
    } on FirebaseException catch (e) {
      throw e.toString();
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
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

  // Fetch a Single Product and Listen to Changes
  Stream<Product> getProductByID(int productID) {
    try {
      DocumentReference reference = _db.collection('Products').doc(productID.toString());
      return reference
          .snapshots()
          .map((snapshot) => Product.fromSnapshot(snapshot as DocumentSnapshot<Map<String, dynamic>>));
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

  // Fetch Single Product Without Listening
  Future<Product> getProductByIDListenOff(int productId) {
    try {
      final product = _db.collection('Products').doc(productId.toString()).get();
      return product.then((snapshot) => Product.fromSnapshot(snapshot));
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

  // Fetch Multiple Products By their IDs
  Future<List<Product>> getProductsByIds(List<int> productIds) async {
    try {
      // Turn products ids to String list so we can use `whereIn`
      List<String> productIdsString = productIds.map((e) => e.toString()).toList();

      // Split productIds into chunks if necessary since Firestore `whereIn` supports a maximum of 10 elements per query.
      List<List<String>> chunks = [];
      const int chunkSize = 10; // Firestore limit
      for (var i = 0; i < productIdsString.length; i += chunkSize) {
        chunks.add(productIdsString.sublist(
            i, i + chunkSize > productIdsString.length ? productIdsString.length : i + chunkSize));
      }

      List<Product> products = [];
      for (List<String> chunk in chunks) {
        // Perform a query for each chunk
        var querySnapshot = await _db.collection('Products').where(FieldPath.documentId, whereIn: chunk).get();
        for (var doc in querySnapshot.docs) {
          products.add(Product.fromSnapshot(doc));
        }
      }

      return products;
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Error: ${e.toString()}';
    }
  }

  // Fetch Single Product Without Listening
  Future<void> updateProduct(Product product) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference productRef = firestore.collection('Products').doc(product.id.toString());
    await productRef.update(product.toJson());
  }

// Fetch Product Reviews
  Future<List<RatingModel>> getProductReviews(int productID) async {
    try {
      if (productID < 0) {
        return List.empty();
      }
      final snapshot = await _db.collection('Products').doc(productID.toString()).collection('Reviews').get();

      //Set users profile image for each review
      final data = snapshot.docs.map((doc) => RatingModel.fromSnapshot(doc)).toList();
      for (var element in data) {
        element.userImage = await getUserProfileImage(element.userID);
      }
      return data;
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

  // Add Product Review
  Future<void> addProductReview(int productID, RatingModel ratingModel) async {
    try {
      // Get Product Rating
      final productSnapshot = await _db.collection('Products').doc(productID.toString()).get();
      final product = Product.fromSnapshot(productSnapshot);

      // Calculate New Rating
      double? newRating = 0;

      if (product.rating == 0) {
        newRating = ratingModel.rating.toDouble();
      } else {
        newRating = (product.rating + ratingModel.rating) / 2;
      }

      // Add the new Review
      await _db.collection('Products').doc(productID.toString()).collection('Reviews').doc().set(ratingModel.toJson());

      // Update Product Rating
      await _db.collection('Products').doc(productID.toString()).update({'rating': newRating});
      await _db.collection('Products').doc(productID.toString()).update({'intRating': newRating.toInt()});
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
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
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

  Future<List<Product>> getNewProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('isPopular', isEqualTo: true).get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

  // Search Products
  Future<List<Product>> searchProducts(String keyword, int limit) async {
    try {
      keyword = keyword.toLowerCase();
      var tags = keyword.split(' ');
      final snapshot = await _db
          .collection('Products')
          .where(Filter.or(Filter('tags', arrayContainsAny: tags),
              Filter("brand", isEqualTo: keyword.substring(0, 1).toUpperCase() + keyword.substring(1))))
          .limit(limit)
          .get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

  // Get Product remaining stock of a variant
  Future<int> getProductStockFromVariant(int productID, String color, String size) async {
    var product = await getProductByIDListenOff(productID);
    var variant = product.variants.firstWhere((element) => element.color == color);
    var stock = variant.size.firstWhere((element) => element.size == size).stock;
    return stock;
  }

  // Get Product remaining stock of all variants
  Future<int> getProductStock(int productID) async {
    var product = await getProductByIDListenOff(productID);
    return product.getStock;
  }
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});
