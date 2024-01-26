import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteItemModel {
  final String id;
  final String title;
  final String image;
  final double price;

  FavoriteItemModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  // Factory constructor for creating a new FavoriteItemModel instance from a map.
  factory FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavoriteItemModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }

  // Method to convert FavoriteItemModel instance to a map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
    };
  }

  // Factory constructor for creating a new FavoriteItemModel instance from a Firestore document snapshot.
  factory FavoriteItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data()!;
    return FavoriteItemModel(
      id: data['id'],
      title: data['title'],
      image: data['image'],
      price: data['price'].toDouble(),
    );
  }

  // Static method to provide an empty FavoriteItemModel.
  static FavoriteItemModel empty() {
    return FavoriteItemModel(
      id: '',
      title: '',
      image: '',
      price: 0.0,
    );
  }
}
