import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_exceptions.dart';

class FavoriteRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  // Add item to favorite
  Future<void> addItemToFavorite(int productId) async {
    try {
      await _db.collection("Users").doc(user?.uid).collection('Favorite').doc(productId.toString()).set({});
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Get User's favorite product IDs
  Stream<List<int>> getUserFavoriteProductIds() {
    return _db.collection('Users').doc(user?.uid).collection('Favorite').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => int.parse(doc.id)).toList();
    });
  }

  // Remove All items from User's favorite
  Future<void> removeAllItemsFromFavorite() async {
    var snapshot = await _db.collection('Users').doc(user?.uid).collection('Favorite').get();
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
  }

  // Remove item from User's favorite
  Future<void> removeSingleItemFromFavorite(int productId) async {
    await _db.collection('Users').doc(user?.uid).collection('Favorite').doc(productId.toString()).delete();
  }
}

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepository();
});
