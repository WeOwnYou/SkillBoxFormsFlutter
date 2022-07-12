import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';

class HomeViewModel extends ChangeNotifier {
  final BuildContext _context;
  List<HotelPreview> _hotels = [];
  String _errorMessage = '';
  bool _isLoading = false;
  bool _hasError = false;
  bool _isOneTitleInARow = true;

  List<HotelPreview> get hotels => _hotels;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isOneTitleInARow => _isOneTitleInARow;

  HomeViewModel(this._context) {
    _getDioHotels();
  }

  _getDioHotels() async {
    _isLoading = true;
    try {
      final response = await Dio()
          .get("https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301");
      List<Map<String, dynamic>> data =
          response.data.cast<Map<String, dynamic>>();
      _hotels = data.map((hotel) => HotelPreview.fromJson(hotel)).toList();
    } on DioError catch (e) {
      _errorMessage = e.message;
      _hasError = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  makeOneTitleInARow() {
    _isOneTitleInARow = true;
    notifyListeners();
  }

  makeTwoTitlesInARow() {
    _isOneTitleInARow = false;
    notifyListeners();
  }

  navigateToDetailsScreen(index) {
    Navigator.pushNamed(_context, '/hotel_details',
        arguments: _hotels[index].uuid);
    // Navigator.push
  }
}
