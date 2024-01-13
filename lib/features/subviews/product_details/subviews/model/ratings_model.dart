import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String userID;
  final String name;
  final String comment;
  final num rating;
  final String date;
  String? userImage;

  RatingModel({
    required this.userID,
    required this.name,
    required this.comment,
    required this.rating,
    required this.date,
    this.userImage,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      userID: json['userID'],
      name: json['name'],
      comment: json['comment'],
      rating: json['rating'],
      date: json['date'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'name': name,
      'comment': comment,
      'rating': rating,
      'date': date,
    };
  }

  factory RatingModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return RatingModel(
      userID: snapshot['userID'],
      name: snapshot['name'],
      comment: snapshot['comment'],
      rating: snapshot['rating'],
      date: snapshot['date'],
    );
  }

  factory RatingModel.empty() {
    return RatingModel(
      userID: '',
      name: '',
      comment: '',
      rating: 0,
      date: '',
    );
  }
}
