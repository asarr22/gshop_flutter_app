import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final double couponValue;
  final String title;
  final String orderDate;
  final String orderETA;
  final String orderID;
  final List<OrderItems> orderItems;
  final List<String> orderDateStatus;
  final List<String> orderTimeStatus;
  final int orderStatus;
  final String paymentMethod;
  String paymentMethodCode;
  int get subtotal {
    return orderItems.fold(0, (x, item) => x + (item.price.toInt() * item.quantity));
  }

  final int deliveryFee;
  final double totalAmount;
  final String userAddress;
  final String userID;
  final String username;
  final String userPhone;

  OrderModel(
      {required this.couponValue,
      required this.title,
      required this.orderDate,
      required this.orderETA,
      required this.orderID,
      required this.orderItems,
      required this.orderDateStatus,
      required this.orderTimeStatus,
      required this.orderStatus,
      required this.paymentMethod,
      required this.paymentMethodCode,
      required this.totalAmount,
      required this.userAddress,
      required this.userID,
      required this.username,
      required this.deliveryFee,
      required this.userPhone});

  // To Json
  Map<String, dynamic> toJson() {
    return {
      'couponValue': couponValue,
      'title': title,
      'orderDate': orderDate,
      'orderETA': orderETA,
      'orderID': orderID,
      'orderItems': orderItems.map((e) => e.toJson()).toList(),
      'orderDateStatus': orderDateStatus,
      'orderTimeStatus': orderTimeStatus,
      'orderStatus': orderStatus,
      'paymentMethod': paymentMethod,
      'paymentMethodCode': paymentMethodCode,
      'totalAmount': totalAmount,
      'userAddress': userAddress,
      'userID': userID,
      'username': username,
      'deliveryFee': deliveryFee,
      'userPhone': userPhone,
    };
  }

  // JSON deserialization
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        couponValue: json['couponValue'],
        title: json['title'],
        orderDate: json['orderDate'],
        orderETA: json['orderETA'],
        orderID: json['orderID'],
        orderItems: (json['orderItems'] as List).map((e) => OrderItems.fromJson(e)).toList(),
        orderDateStatus: json['orderDateStatus'] != null ? List<String>.from(json['orderDateStatus']) : [],
        orderTimeStatus: json['orderTimeStatus'] != null ? List<String>.from(json['orderTimeStatus']) : [],
        orderStatus: json['orderStatus'],
        paymentMethod: json['paymentMethod'],
        paymentMethodCode: json['paymentMethodCode'],
        totalAmount: json['totalAmount'],
        userAddress: json['userAddress'],
        userID: json['userID'],
        deliveryFee: json['deliveryFee'],
        username: json['username'],
        userPhone: json['userPhone']);
  }

  // From Snapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return OrderModel(
        couponValue: snapshot['couponValue'],
        title: snapshot['title'],
        orderDate: snapshot['orderDate'],
        orderETA: snapshot['orderETA'],
        orderID: snapshot['orderID'],
        orderItems: (snapshot['orderItems'] as List).map((e) => OrderItems.fromSnapshot(e)).toList(),
        orderDateStatus: snapshot['orderDateStatus'] != null ? List<String>.from(snapshot['orderDateStatus']) : [],
        orderTimeStatus: snapshot['orderTimeStatus'] != null ? List<String>.from(snapshot['orderTimeStatus']) : [],
        orderStatus: snapshot['orderStatus'],
        paymentMethod: snapshot['paymentMethod'],
        paymentMethodCode: snapshot['paymentMethodCode'],
        totalAmount: snapshot['totalAmount'],
        userAddress: snapshot['userAddress'],
        userID: snapshot['userID'],
        deliveryFee: snapshot['deliveryFee'],
        username: snapshot['username'],
        userPhone: snapshot['userPhone']);
  }

  // Empty Order
  factory OrderModel.empty() {
    return OrderModel(
      couponValue: 0.0,
      title: '',
      orderDate: '',
      orderETA: '',
      orderID: '',
      orderItems: [OrderItems.empty()],
      orderDateStatus: [],
      orderTimeStatus: [],
      orderStatus: 0,
      paymentMethod: '',
      paymentMethodCode: '',
      totalAmount: 0.0,
      userAddress: '',
      userID: '',
      username: '',
      deliveryFee: 0,
      userPhone: '',
    );
  }
}

class OrderItems {
  String name;
  String image;
  double price;
  int quantity;
  String color;
  String size;
  String iD;

  OrderItems({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.size,
    required this.iD,
    required this.color,
  });

  // To Json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'size': size,
      'id': iD,
      'color': color,
    };
  }

  // JSON deserialization
  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return OrderItems(
      name: json['name'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
      size: json['size'],
      iD: json['id'],
      color: json['color'],
    );
  }

  // From Snapshot
  factory OrderItems.fromSnapshot(Map<String, dynamic> snapshot) {
    return OrderItems(
      name: snapshot['name'],
      image: snapshot['image'],
      price: snapshot['price'],
      quantity: snapshot['quantity'],
      size: snapshot['size'],
      iD: snapshot['id'],
      color: snapshot['color'],
    );
  }

  // Empty OrderItem
  factory OrderItems.empty() {
    return OrderItems(
      name: '',
      image: '',
      price: 0.0,
      quantity: 0,
      size: '',
      iD: '',
      color: '',
    );
  }
}
