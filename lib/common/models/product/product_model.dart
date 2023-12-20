import 'package:gshopp_flutter/utils/constants/images_values.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final int discountValue;
  final String brand;
  final List<Variant> variants;
  final int totalStock;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.discountValue,
    required this.brand,
    required this.variants,
    required this.totalStock,
  });
}

class Variant {
  final String size;
  final String color;
  final int stock;
  final int price;

  Variant({
    required this.price,
    required this.size,
    required this.color,
    required this.stock,
  });
}

class ProductModel {
  List<Product> products = [
    Product(
      id: '1',
      title: 'Galaxy S23 FE',
      description:
          'Samsung Galaxy S23 FE is powered by an octa-core processor. It comes with 8GB of RAM. The Samsung Galaxy S23 FE runs Android 13 and is powered by a 4500mAh non-removable battery. The Samsung Galaxy S23 FE supports wireless charging, as well as proprietary fast charging.',
      price: 305000,
      imageUrl: ImagesValue.productImg1,
      discountValue: 10,
      brand: 'Samsung',
      totalStock: 60,
      variants: [
        Variant(size: '128 GB', color: '#FF0000', stock: 8, price: 305000),
        Variant(size: '256 GB', color: '#FF0000', stock: 7, price: 325000),
        Variant(size: '256 GB', color: '#8F4610', stock: 3, price: 325000),
        Variant(size: '512 GB', color: '#0000FF', stock: 9, price: 345000),
        Variant(size: '512 GB', color: '#0000FF', stock: 2, price: 345000),
        Variant(size: '1TB', color: '#00FF44', stock: 2, price: 365000),
      ],
    ),
    Product(
      id: '2',
      title: 'iPhone 13 Pro Max',
      description:
          'The iPhone 13 Pro Max is the largest and most expensive model in Apple\'s 2021 smartphone line-up and features a 6.7-inch Super Retina XDR display with 1284 x 2778 pixels resolution. Like the smaller iPhone 13 Pro, it is powered by Apple\'s latest A15 Bionic chipset and comes with up to 1TB of internal storage.',
      price: 399000,
      imageUrl: ImagesValue.productImg2,
      discountValue: 20,
      brand: 'Apple',
      totalStock: 60,
      variants: [
        Variant(size: '128 GB', color: '#FF0000', stock: 8, price: 305000),
        Variant(size: '256 GB', color: '#FF0000', stock: 7, price: 325000),
        Variant(size: '256 GB', color: '#8F4610', stock: 3, price: 325000),
        Variant(size: '512 GB', color: '#0000FF', stock: 9, price: 345000),
        Variant(size: '512 GB', color: '#0000FF', stock: 2, price: 345000),
        Variant(size: '1TB', color: '#00FF44', stock: 2, price: 365000),
      ],
    ),
    Product(
      id: '3',
      title: 'Huawei Watch GT 4',
      description:
          'HUAWEI WATCH GT 3 46 mm lasts up to 14 days, so you\'re fully prepared to keep track of your every workout and not miss out on any health check. It supports wireless charging, so you can use your phone to reverse charge it when you forget your charger and say goodbye to battery life anxiety.',
      price: 128000,
      imageUrl: ImagesValue.productImg3,
      discountValue: 8,
      brand: 'Huawei',
      totalStock: 60,
      variants: [
        Variant(size: '43 mm', color: '#FF0000', stock: 5, price: 105000),
        Variant(size: '43 mm', color: '#FF0000', stock: 7, price: 105000),
        Variant(size: '43 mm', color: '#8F4610', stock: 3, price: 105000),
        Variant(size: '44 mm', color: '#0000FF', stock: 3, price: 105000),
        Variant(size: '44 mm', color: '#0000FF', stock: 1, price: 105000),
        Variant(size: '43 mm', color: '#00FF44', stock: 2, price: 105000),
      ],
    ),
    Product(
      id: '4',
      title: 'MacBook Pro M3',
      description:
          'Apple 2023 MacBook Pro Laptop M3 chip with 8‑core CPU, 10‑core GPU: 14.2-inch Liquid Retina XDR Display, 8GB Unified Memory, 512GB SSD Storage. Works with iPhone/iPad; Space Gray. The List Price is the suggested retail price of a new product as provided by a manufacturer, supplier, or seller.',
      price: 910500,
      imageUrl: ImagesValue.productImg4,
      discountValue: 13,
      brand: 'Apple',
      totalStock: 60,
      variants: [
        Variant(size: '128/8 GB', color: '#FF0000', stock: 8, price: 705000),
        Variant(size: '256/8 GB', color: '#FF0000', stock: 7, price: 825000),
        Variant(size: '256/16 GB', color: '#8F4610', stock: 3, price: 825000),
        Variant(size: '512/16 GB', color: '#0000FF', stock: 9, price: 945000),
        Variant(size: '512/32 GB', color: '#0000FF', stock: 2, price: 945000),
        Variant(size: '2TB/128', color: '#00FF44', stock: 2, price: 1765000),
      ],
    ),
  ];

  int get count => products.length;

  Product getByIndex(int index) {
    return products[index];
  }
}
