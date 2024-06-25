import 'package:flutter/material.dart';
import 'package:opinion_price/constants/app_color.dart';
import 'package:provider/provider.dart';

import 'controllers/chart_controller.dart';
import 'views/chart_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ChartController>(
      create: (context) => ChartController(),
      child: const OpinionPriceApp(),
    ),
  );
}

class OpinionPriceApp extends StatelessWidget {
  const OpinionPriceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Opinion Price App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const  AppBarTheme(
          backgroundColor:  AppColors.itemsBackground
        ),
        scaffoldBackgroundColor: AppColors.primary
      ),
      home: const ChartScreen(),
    );
  }
}
