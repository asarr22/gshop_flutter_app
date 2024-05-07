import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/user/favorite_item_model.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/format_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/platform_exceptions.dart';

class FavoriteRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  // Add item to favorite
  Future<void> addItemToFavorite(FavoriteItemModel userCartItemModel) async {
    try {
      final json = userCartItemModel.toJson();
      await _db.collection("Users").doc(user?.uid).collection('Favorite').doc().set(json);
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Get User's favorite items
  Stream<List<FavoriteItemModel>> getUserFavoriteItems() {
    try {
      return _db.collection('Users').doc(user?.uid).collection('Favorite').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => FavoriteItemModel.fromSnapshot(doc)).toList();
      });
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Remove All items from User's favorite
  Future<void> removeAllItemsFromFavorite() async {
    try {
      await _db.collection('Users').doc(user?.uid).collection('Favorite').get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Remove item from User's favorite
  Future<void> removeSingleItemFromFavorite(String productID) async {
    try {
      var query = await _db.collection('Users').doc(user?.uid).collection('Favorite').get();

      for (var doc in query.docs) {
        if (doc.data()['id'] == productID) {
          await _db.collection('Users').doc(user?.uid).collection('Favorite').doc(doc.id).delete();
        }
      }
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepository();
});
