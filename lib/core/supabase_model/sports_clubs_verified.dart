import 'dart:convert';

class SportsClubsVerified {
  final String id;
  final String name;
  final String type;
  final String latitude;
  final String longitude;
  final String rate;
  final String number_rated;
  final String price;
  final String phone_number;
  final List<String> images;
  final String created_at;
  final String added_by;
  double distance;

  SportsClubsVerified({
    required this.id,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.rate,
    required this.number_rated,
    required this.price,
    required this.phone_number,
    required this.images,
    required this.created_at,
    required this.added_by,
    required this.distance,
  });

  factory SportsClubsVerified.fromJson(Map<String, dynamic> e) {
    return SportsClubsVerified(
      id: e['id']?.toString() ?? '',
      name: e['name']?.toString() ?? '',
      type: e['type']?.toString() ?? '',
      latitude: e['latitude']?.toString() ?? '',
      longitude: e['longitude']?.toString() ?? '',
      rate: e['rate']?.toString() ?? '',
      number_rated: e['number_rated']?.toString() ?? '',
      price: e['price']?.toString() ?? '',
      phone_number: e['phone_number']?.toString() ?? '',
      images: e['images'] is List
          ? (e['images'] as List).map((img) => img.toString()).toList()
          : (e['images'] is String && e['images'].isNotEmpty)
          ? List<String>.from(jsonDecode(e['images']))
          : <String>[],
      created_at: e['created_at']?.toString() ?? '',
      added_by: e['added_by']?.toString() ?? '',
      distance: e['distance'] != null ? (e['distance'] as num).toDouble() : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'rate': rate,
      'number_rated': number_rated,
      'price': price,
      'phone_number': phone_number,
      'images': images,
      'created_at': created_at,
      'added_by': added_by,
      'distance': distance,
    };
  }
}

class SportsClubsVerifiedModel {
  final String id = 'id';
  final String name = 'name';
  final String type = 'type';
  final String latitude = 'latitude';
  final String longitude = 'longitude';
  final String rate = 'rate';
  final String number_rated = 'number_rated';
  final String price = 'price';
  final String phone_number = 'phone_number';
  final String images = 'images';
  final String created_at = 'created_at';
  final String added_by = 'added_by';
}
