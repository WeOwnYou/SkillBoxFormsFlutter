import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/models/hotel_details.dart';

class DetailsViewModel extends ChangeNotifier {
  final BuildContext _context;
  HotelDetails? _hotelDetails;
  String _uuid = '';

  bool _hasError = false;
  bool _isLoading = true;
  String _errorMessage = '';
  HotelDetails? get hotelDetails => _hotelDetails;
  bool get hasError => _hasError;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  DetailsViewModel(this._context);

  _getDioDetails() async {
    if (!isLoading) return;
    try {
      final response = await Dio().get("https://run.mocky.io/v3/$_uuid");
      final Map<String, dynamic> data = response.data;
      _hotelDetails = HotelDetails.fromJson(data);
    } on DioError catch (e) {
      _errorMessage = e.message;
      _hasError = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  init({required String uuid}) {
    _uuid = uuid;
    _getDioDetails();
  }
}
