import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final List<String> imageUrl;
  final int discountValue;
  int? promoDiscountValue;
  final String brand;
  final List<Variant> variants;
  final int totalStock;
  final bool isPopular;
  final int intRating;
  final num rating;
  final bool isNew;
  final String? promoCode;
  final String publishDate;
  final String category;
  final String subCategory;
  final String sellerID;
  List<String>? tags;
  int get getStock {
    return variants.fold(0, (sums, item) => sums + item.stock);
  }

  int get price {
    return variants[0].size[0].price;
  }

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.discountValue,
    this.promoDiscountValue,
    required this.brand,
    required this.variants,
    required this.totalStock,
    required this.isPopular,
    required this.rating,
    required this.isNew,
    required this.publishDate,
    required this.category,
    required this.intRating,
    required this.subCategory,
    required this.sellerID,
    this.promoCode,
    this.tags,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'discountValue': discountValue,
      'promoDiscountValue': promoDiscountValue,
      'brand': brand,
      'variants': variants.map((v) => v.toJson()).toList(),
      'totalStock': totalStock,
      'isPopular': isPopular,
      'rating': rating,
      'isNew': isNew,
      'publishDate': publishDate,
      'category': category,
      'subCategory': subCategory,
      'intRating': intRating,
      'sellerID': sellerID,
      'promoCode': promoCode,
      'tags': tags
    };
  }

  // JSON deserialization
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      discountValue: json['discountValue'],
      promoDiscountValue: json['promoDiscountValue'],
      brand: json['brand'],
      variants: (json['variants'] as List).map((v) => Variant.fromJson(v)).toList(),
      isPopular: json['isPopular'],
      totalStock: json['totalStock'],
      rating: json['rating'],
      isNew: json['isNew'],
      publishDate: json['publishDate'],
      category: json['category'],
      subCategory: json['subCategory'],
      sellerID: json['sellerID'],
      intRating: json['intRating'],
      promoCode: json['promoCode'],
      tags: List<String>.from(json['tags']),
    );
  }

  factory Product.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    int intRate = snapshot['intRating']?.toInt() ?? 0;

    int promoDiscountValue = snapshot.data()?['promoDiscountValue'] as int? ?? 0;
    int id = snapshot['id'] as int;
    return Product(
        id: id,
        title: snapshot['title'],
        description: snapshot['description'],
        imageUrl: List<String>.from(snapshot['imageUrl']),
        discountValue: snapshot['discountValue'],
        promoDiscountValue: promoDiscountValue,
        brand: snapshot['brand'],
        isPopular: snapshot['isPopular'],
        variants: (snapshot['variants'] as List).map((v) => Variant.fromSnapshot(v)).toList(),
        totalStock: (snapshot['totalStock']),
        rating: snapshot['rating'],
        isNew: snapshot['isNew'],
        publishDate: snapshot['publishDate'],
        category: snapshot['category'],
        subCategory: snapshot['subCategory'],
        sellerID: snapshot['sellerID'],
        intRating: intRate,
        promoCode: snapshot['promoCode'],
        tags: List<String>.from(snapshot['tags']));
  }

  static Product empty() => Product(
        id: -1,
        title: '',
        description: '',
        imageUrl: [],
        discountValue: 0,
        promoDiscountValue: 0,
        brand: '',
        variants: [Variant.empty()],
        totalStock: 0,
        isPopular: false,
        rating: 0,
        isNew: false,
        publishDate: '',
        category: '',
        intRating: 0,
        subCategory: '',
        sellerID: '',
        promoCode: '',
        tags: [],
      );
}

class Variant {
  final String color;
  final List<Size> size;
  int get stock {
    return size.fold(0, (sums, item) => sums + item.stock);
  }

  Variant({
    required this.size,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'size': size.map((s) => s.toJson()).toList(),
    };
  }

  // JSON deserialization
  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      color: json['color'],
      size: (json['size'] as List).map((s) => Size.fromJson(s)).toList(),
    );
  }

  factory Variant.fromSnapshot(Map<String, dynamic> snapshot) {
    return Variant(
      color: snapshot['color'],
      size: (snapshot['size'] as List).map((s) => Size.fromSnapshot(s)).toList(),
    );
  }

  static Variant empty() => Variant(
        color: '',
        size: [Size.empty()],
      );
}

class Size {
  final String size;
  int stock;
  final int price;
  Size({required this.size, required this.stock, required this.price});

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'stock': stock,
      'price': price,
    };
  }

  // JSON deserialization
  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      size: json['size'],
      stock: json['stock'],
      price: json['price'],
    );
  }
  factory Size.fromSnapshot(Map<String, dynamic> snapshot) {
    // To avoid dart bug we will receive price as num then cast it to int
    num price = snapshot['price'];

    return Size(
      size: snapshot['size'],
      stock: snapshot['stock'],
      price: price.toInt(),
    );
  }

  static Size empty() => Size(
        size: '',
        stock: 0,
        price: 0,
      );
}
