import 'dart:async';
import 'dart:math';

import '../models/price_data.dart';

class PriceService {

  /// Fetches a list of historical price data.
  ///
  /// This method simulates fetching historical price data by generating
  /// random prices for the past 100 minutes. The generated data is returned
  /// in chronological order from the oldest to the most recent.
  List<PriceData> fetchPriceHistory() {
    List<PriceData> history = [];
    DateTime now = DateTime.now();
    Random random = Random();
    for (int i = 0; i < 100; i++) {
      double price = (random.nextDouble() * 3.0) + 2;
      history.add(PriceData(now.subtract(Duration(seconds: i)), price));
    }
    return history.reversed.toList();
  }

  /// Provides a stream of real-time price updates.
  ///
  /// This method simulates real-time price updates by generating a new
  /// random price every 2 seconds and yielding it as a [PriceData] object.
  /// The stream continues indefinitely, producing a new price at each interval
  Stream<PriceData> fetchPriceUpdates() async* {
    Random random = Random();
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      yield PriceData(DateTime.now(), (random.nextDouble() * 3.0) + 2);
    }
  }
}
