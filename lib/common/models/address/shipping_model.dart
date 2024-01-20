import 'package:cloud_firestore/cloud_firestore.dart';

class City {
  String name;
  List<Zone> zones;

  City({required this.name, required this.zones});

  factory City.fromJson(Map<String, dynamic> json) {
    var zonesJson = json['zones'] as List<dynamic>;
    List<Zone> zones = zonesJson.map((zoneJson) => Zone.fromJson(zoneJson)).toList();
    return City(
      name: json['name'],
      zones: zones,
    );
  }

  get shippingFee => null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'zones': zones.map((zone) => zone.toJson()).toList(),
    };
  }

  factory City.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    var zonesJson = data['zones'] as List<dynamic>;
    List<Zone> zones = zonesJson.map((zoneJson) {
      Map<String, dynamic> zoneData = Map<String, dynamic>.from(zoneJson);
      zoneData['id'] = zoneData['id'] ?? snapshot.id;
      return Zone.fromJson(zoneData);
    }).toList();
    return City(name: data['name'], zones: zones);
  }
}

class Zone {
  String id;
  String name;
  double shippingFee;

  Zone({required this.id, required this.name, required this.shippingFee});

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'],
      name: json['name'],
      shippingFee: json['shippingFee'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shippingFee': shippingFee,
    };
  }
}
