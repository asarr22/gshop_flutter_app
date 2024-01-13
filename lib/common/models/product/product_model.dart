import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final List<String> imageUrl;
  final int discountValue;
  final String brand;
  final List<Variant> variants;
  final int totalStock;
  final bool isPopular;
  final num rating;
  int get price {
    return variants[0].size[0].price;
  }

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.discountValue,
    required this.brand,
    required this.variants,
    required this.totalStock,
    required this.isPopular,
    required this.rating,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'discountValue': discountValue,
      'brand': brand,
      'variants': variants.map((v) => v.toJson()).toList(),
      'totalStock': totalStock,
      'isPopular': isPopular,
      'rating': rating,
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
      brand: json['brand'],
      variants: (json['variants'] as List).map((v) => Variant.fromJson(v)).toList(),
      isPopular: json['isPopular'],
      totalStock: json['totalStock'],
      rating: json['rating'],
    );
  }

  factory Product.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Product(
      id: snapshot['id'],
      title: snapshot['title'],
      description: snapshot['description'],
      imageUrl: List<String>.from(snapshot['imageUrl']),
      discountValue: snapshot['discountValue'],
      brand: snapshot['brand'],
      isPopular: snapshot['isPopular'],
      variants: (snapshot['variants'] as List).map((v) => Variant.fromSnapshot(v)).toList(),
      totalStock: (snapshot['totalStock']),
      rating: snapshot['rating'],
    );
  }

  static Product empty() => Product(
        id: '',
        title: '',
        description: '',
        imageUrl: [],
        discountValue: 0,
        brand: '',
        variants: [Variant.empty()],
        totalStock: 0,
        isPopular: false,
        rating: 0,
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
  final int stock;
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

class ProductModel {
  List<Product> products = [
    Product(
      id: '1',
      title: 'Galaxy S23 FE',
      description:
          'Samsung Galaxy S23 FE is powered by an octa-core processor. It comes with 8GB of RAM. The Samsung Galaxy S23 FE runs Android 13 and is powered by a 4500mAh non-removable battery. The Samsung Galaxy S23 FE supports wireless charging, as well as proprietary fast charging.',
      imageUrl: [ImagesValue.productImg1],
      discountValue: 10,
      brand: 'Samsung',
      totalStock: 60,
      isPopular: false,
      rating: 4.5,
      variants: [
        Variant(
          size: [
            Size(size: '128 GB', stock: 4, price: 325000),
            Size(size: '256 GB', stock: 5, price: 375000),
            Size(size: '512 GB', stock: 10, price: 395000),
          ],
          color: '#FF0000',
        ),
        Variant(
          size: [
            Size(size: '256 GB', stock: 4, price: 375000),
            Size(size: '512 GB', stock: 10, price: 395000),
          ],
          color: '#8F4610',
        ),
        Variant(
          size: [
            Size(size: '256 GB', stock: 4, price: 375000),
            Size(size: '512 GB', stock: 4, price: 395000),
            Size(size: '1TB GB', stock: 4, price: 395000),
          ],
          color: '#0000FF',
        ),
      ],
    ),
    Product(
      id: '2',
      title: 'iPhone 13 Pro Max',
      description:
          'The iPhone 13 Pro Max is the largest and most expensive model in Apple\'s 2021 smartphone line-up and features a 6.7-inch Super Retina XDR display with 1284 x 2778 pixels resolution. Like the smaller iPhone 13 Pro, it is powered by Apple\'s latest A15 Bionic chipset and comes with up to 1TB of internal storage.',
      isPopular: false,
      imageUrl: [ImagesValue.productImg2],
      discountValue: 20,
      brand: 'Apple',
      totalStock: 60,
      rating: 4.5,
      variants: [
        Variant(
          size: [
            Size(size: '128 GB', stock: 4, price: 325000),
            Size(size: '256 GB', stock: 5, price: 375000),
            Size(size: '512 GB', stock: 10, price: 395000),
          ],
          color: '#FF0000',
        ),
        Variant(
          size: [
            Size(size: '256 GB', stock: 4, price: 375000),
            Size(size: '512 GB', stock: 10, price: 395000),
          ],
          color: '#8F4610',
        ),
        Variant(
          size: [
            Size(size: '256 GB', stock: 4, price: 375000),
            Size(size: '512 GB', stock: 4, price: 395000),
            Size(size: '1TB GB', stock: 4, price: 395000),
          ],
          color: '#0000FF',
        ),
      ],
    ),
    Product(
      id: '3',
      title: 'Huawei Watch GT 4',
      description:
          'HUAWEI WATCH GT 3 46 mm lasts up to 14 days, so you\'re fully prepared to keep track of your every workout and not miss out on any health check. It supports wireless charging, so you can use your phone to reverse charge it when you forget your charger and say goodbye to battery life anxiety.',
      isPopular: false,
      imageUrl: [ImagesValue.productImg3],
      discountValue: 8,
      brand: 'Huawei',
      totalStock: 60,
      rating: 4.5,
      variants: [
        Variant(
          size: [Size(size: '42mm', stock: 4, price: 105000)],
          color: '#FF0000',
        ),
        Variant(
          size: [
            Size(size: '42mm', stock: 4, price: 105000),
            Size(size: '45mm', stock: 7, price: 125000),
          ],
          color: '#8F4610',
        ),
        Variant(
          size: [Size(size: '45mm', stock: 1, price: 125000)],
          color: '#0000FF',
        ),
      ],
    ),
    Product(
      id: '4',
      title: 'MacBook Pro M3',
      description:
          'Apple 2023 MacBook Pro Laptop M3 chip with 8‑core CPU, 10‑core GPU: 14.2-inch Liquid Retina XDR Display, 8GB Unified Memory, 512GB SSD Storage. Works with iPhone/iPad; Space Gray. The List Price is the suggested retail price of a new product as provided by a manufacturer, supplier, or seller.',
      isPopular: false,
      imageUrl: [ImagesValue.productImg4],
      discountValue: 13,
      brand: 'Apple',
      rating: 4.5,
      totalStock: 60,
      variants: [
        Variant(
          size: [
            Size(size: '256/16 GB', stock: 4, price: 975000),
            Size(size: '512/16 GB', stock: 4, price: 1395000),
          ],
          color: '#FF0000',
        ),
        Variant(
          size: [
            Size(size: '256/16 GB', stock: 4, price: 975000),
            Size(size: '512/16 GB', stock: 4, price: 1395000),
          ],
          color: '#8F4610',
        ),
        Variant(
          size: [
            Size(size: '256/16 GB', stock: 4, price: 975000),
            Size(size: '512/16 GB', stock: 4, price: 1395000),
            Size(size: '1TB/32', stock: 4, price: 1595000),
          ],
          color: '#0000FF',
        ),
      ],
    ),
  ];

  int get count => products.length;

  Product getByIndex(int index) {
    return products[index];
  }
}
