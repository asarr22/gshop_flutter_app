import 'package:cloud_firestore/cloud_firestore.dart';

class UserCartItemModel {
  String productId;
  int quantity;
  String createdAt;
  String productName;
  String productImage;
  int productPrice;
  String color;
  String size;

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