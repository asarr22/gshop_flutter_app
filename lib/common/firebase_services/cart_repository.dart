import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gshopp_flutter/common/models/user/user_cart_model.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/format_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/platform_exceptions.dart';

class UserCartRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  // Add item to User's cart
  Future<void> addItemToCart(UserCartItemModel userCartItemModel) async {
    try {
      final json = userCartItemModel.toJson();
      await _db.collection("Users").doc(user?.uid).collection('Cart').doc().set(json);
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

  // Get User's cart items
  Stream<List<UserCartItemModel>> getUserCartItems() {
    try {
      return _db.collection('Users').doc(user?.uid).collection('Cart').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => UserCartItemModel.fromSnapshot(doc)).toList();
      });
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

  // Remove All items from User's cart
  Future<void> removeAllItemsFromCart() async {
    try {
      await _db.collection('Users').doc(user?.uid).collection('Cart').get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
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

  // Remove item from User's cart
  Future<void> removeSingleItemFromCart(UserCartItemModel item) async {
    try {
      var jsonData = item.toJson();
      var query = await _db.collection('Users').doc(user?.uid).collection('Cart').get();

      for (var doc in query.docs) {
        Map<String, dynamic> docData = doc.data();
        if (mapEquals(jsonData, docData)) {
          await _db.collection('Users').doc(user?.uid).collection('Cart').doc(doc.id).delete();
        }
      }
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

  // increase or decrease Quantity of item in User's cart
  Future<void> mofidyItemQuantity(UserCartItemModel item, int quantity) async {
    try {
      var oldJson = item.toJson();
      item.quantity = quantity;
      var jsonData = item.toJson();
      var query = await _db.collection('Users').doc(user?.uid).collection('Cart').get();

      for (var doc in query.docs) {
        Map<String, dynamic> docData = doc.data();
        if (mapEquals(oldJson, docData)) {
          await _db.collection('Users').doc(user?.uid).collection('Cart').doc(doc.id).set(jsonData);
        }
      }
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
