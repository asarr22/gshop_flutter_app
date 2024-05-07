import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/order/order_model.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/common/repositories/cart_repository.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/format_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/platform_exceptions.dart';
import '../controllers/user_controller.dart';
import 'product_repository.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(ref);
});

class OrderRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  OrderRepository(this.ref);
  Ref ref;

  // add order
  Future<void> addOrder(OrderModel order) async {
    final productRepository = ref.read(productRepositoryProvider);
    await _db.collection('Orders').doc(order.orderID + order.userID).set(order.toJson());

    // Update Product Stock
    var items = order.orderItems;
    for (var item in items) {
      var product = await productRepository.getProductByIDListenOff(int.parse(item.iD));
      updateProductStock(product, item.color, item.size, item.quantity);
      await productRepository.updateProduct(product);
    }

    // Clean Cart
    await ref.read(cartRepositoryProvider).removeAllItemsFromCart();

    try {} on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw 'Error : ${e.toString()}';
    }
  }

  // Get Order By User ID
  Stream<List<OrderModel>> getOrders() {
    try {
      final userID = ref.watch(userControllerProvider).id;
      return _db.collection('Orders').where('userID', isEqualTo: userID).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
      });
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

  void updateProductStock(Product product, String color, String sizeName, int newStock) {
    for (Variant variant in product.variants) {
      if (variant.color == color) {
        for (Size size in variant.size) {
          if (size.size == sizeName) {
            size.stock = newStock;
            return;
          }
        }
      }
    }
  }
}
