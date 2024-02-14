import 'package:cloud_firestore/cloud_firestore.dart';

class PromoEventModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String startDate;
  final String endDate;

  PromoEventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
  });

  // From Json
  factory PromoEventModel.fromJson(Map<String, dynamic> json) {
    return PromoEventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  // To Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  // From Snapshot
  factory PromoEventModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return PromoEventModel(
      id: snapshot['id'],
      title: snapshot['title'],
      description: snapshot['description'],
      imageUrl: snapshot['imageUrl'],
      startDate: snapshot['startDate'],
      endDate: snapshot['endDate'],
    );
  }
}
