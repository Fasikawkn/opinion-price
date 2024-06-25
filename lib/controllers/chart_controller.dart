import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../models/price_data.dart';
import '../services/price_service.dart';

class ChartController extends ChangeNotifier {
  final PriceService _priceService = PriceService();
  List<PriceData> _priceHistory = [];

  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  ChartController() {
    _initialize();
  }

  List<PriceData> get priceHistory => _priceHistory;

  /// Initializes the chart controller.
  ///
  /// This method fetches the initial historical price data and sets up a listener
  /// for real-time price updates. The historical data is fetched and stored in [_priceHistory]
  /// The real-time price updates are listened to and
  /// appended to [_priceHistory], ensuring the list doesn't exceed 50 data points.
  void _initialize() {
    _priceHistory = _priceService.fetchPriceHistory();
    notifyListeners();
    _priceService.fetchPriceUpdates().listen((priceData) {
      _priceHistory.add(priceData);
      if (_priceHistory.length > 50) {
        _priceHistory.removeAt(0);
      }
      notifyListeners();
    });
  }
}
