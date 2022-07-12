// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelDetails _$HotelDetailsFromJson(Map<String, dynamic> json) => HotelDetails(
      address: json['address'] as Map<String, dynamic>,
      rating: (json['rating'] as num).toDouble(),
      services: (json['services'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$HotelDetailsToJson(HotelDetails instance) =>
    <String, dynamic>{
      'address': instance.address,
      'rating': instance.rating,
      'services': instance.services,
      'photos': instance.photos,
      'name': instance.name,
    };
