import 'package:json_annotation/json_annotation.dart';

part 'hotel_details.g.dart';

@JsonSerializable(explicitToJson: true)
class HotelDetails {
  final Map<String, dynamic> address;
  final double rating;
  final Map<String, List<String>> services;
  final List<String> photos;
  final String name;

  HotelDetails(
      {required this.address,
      required this.rating,
      required this.services,
      required this.photos,
      required this.name});

  factory HotelDetails.fromJson(Map<String, dynamic> json) =>
      _$HotelDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$HotelDetailsToJson(this);
}
