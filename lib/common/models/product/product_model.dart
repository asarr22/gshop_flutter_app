import 'package:gshopp_flutter/utils/constants/images_values.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final List<String> imageUrl;
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

/// The varinat object handle product variation. It depend on color
/// ex : For each color we have 10 item in 1TB in size and 5 item in 256GB
/// There is 2 type of stock : Stock of a single variant and the total of all Stock

class Variant {
  final String color;
  final List<Size> size;
  int get stock {
    return size.fold(0, (sum, item) => sum + item.stock);
  }

  Variant({
    required this.size,
    required this.color,
  });
}

class Size {
  final String size;
  final int stock;
  final double price;
  Size({required this.size, required this.stock, required this.price});
}

class ProductModel {
  List<Product> products = [
    Product(
      id: '1',
      title: 'Galaxy S23 FE',
      description:
          'Samsung Galaxy S23 FE is powered by an octa-core processor. It comes with 8GB of RAM. The Samsung Galaxy S23 FE runs Android 13 and is powered by a 4500mAh non-removable battery. The Samsung Galaxy S23 FE supports wireless charging, as well as proprietary fast charging.',
      price: 305000,
      imageUrl: [ImagesValue.productImg1],
      discountValue: 10,
      brand: 'Samsung',
      totalStock: 60,
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
      price: 399000,
      imageUrl: [ImagesValue.productImg2],
      discountValue: 20,
      brand: 'Apple',
      totalStock: 60,
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
      price: 128000,
      imageUrl: [ImagesValue.productImg3],
      discountValue: 8,
      brand: 'Huawei',
      totalStock: 60,
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
      price: 910500,
      imageUrl: [ImagesValue.productImg4],
      discountValue: 13,
      brand: 'Apple',
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
