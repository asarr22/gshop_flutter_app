import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';

class UserCartItemModel {
  final String productId;
  int quantity;
  final String createdAt;
  final String productName;
  final String productImage;
  int productPrice;
  final String color;
  final String size;
  int appliedDiscountValue = 0;
  void applyDiscount(int discountValue) {
    productPrice = Formatter.applyDiscount(productPrice.toDouble(), discountValue).toInt();
    appliedDiscountValue = discountValue;
  }

  void removeDiscount(int discountValue) {
    productPrice = Formatter.removeDiscount(productPrice.toDouble(), discountValue).toInt();
  }

  UserCartItemModel({
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.color,
    required this.size,
  });

  factory UserCartItemModel.fromJson(Map<String, dynamic> json) {
    return UserCartItemModel(
      productId: json['productId'],
      quantity: json['quantity'],
      createdAt: json['createdAt'],
      productName: json['productName'],
      productImage: json['productImage'],
      productPrice: json['productPrice'],
      color: json['color'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'createdAt': createdAt,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'color': color,
      'size': size,
    };
  }

  // From Snapshot
  factory UserCartItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserCartItemModel(
      productId: snapshot['productId'],
      quantity: snapshot['quantity'],
      createdAt: snapshot['createdAt'],
      productName: snapshot['productName'],
      productImage: snapshot['productImage'],
      productPrice: snapshot['productPrice'],
      color: snapshot['color'],
      size: snapshot['size'],
    );
  }

  // Empty Item
  static UserCartItemModel empty() => UserCartItemModel(
        productId: '',
        quantity: 0,
        createdAt: '',
        productName: '',
        productImage: '',
        productPrice: 0,
        color: '',
        size: '',
      );
}
