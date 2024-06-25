// views/chart_screen.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants/app_color.dart';
import '../constants/text_styles.dart';
import '../controllers/chart_controller.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ChartController>(builder: (context, controller, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Euro cup prediction'),
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (context, _) {
          return _.maxWidth > 600
              ? buildLandscapeView(context, controller)
              : buildPortraitView(context, controller);
        }),
      );
    });
  }

  /// Renders the landscape view
  Widget buildLandscapeView(BuildContext context, ChartController controller) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: buildLandscapePredictionInfo(context),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Flexible(
                  child: LineChart(
                mainData(controller),
              )),
            ],
          ),
        ),
      ],
    );
  }

  /// Renders the portrait view
  Widget buildPortraitView(BuildContext context, ChartController controller) {
    return Column(
      children: [
        buildPortraitPredictionInfo(context),
        Expanded(
          child: LineChart(
            mainData(controller),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  /// Reders the view for the landscape view of the opinion data
  ClipRRect buildLandscapePredictionInfo(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            buildImage(context),
            const SizedBox(
              height: 10.0,
            ),
            buildButtonAndLabelWidget(),
          ],
        ),
      ),
    );
  }

  /// Reders the view for the portrait view of the opinion data
  Widget buildPortraitPredictionInfo(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.19,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Row(
          children: [
            buildImage(context),
            const SizedBox(
              width: 10.0,
            ),
            buildButtonAndLabelWidget(),
          ],
        ),
      ),
    );
  }

  /// Renders the image for opinion
  Flexible buildImage(BuildContext context) {
    return Flexible(
      flex: 1,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD9q2GWjjL0LJDXdS18ngg4bBf1Wq3hZniMQ&s',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  /// Renders the widget data about the opinion
  Flexible buildButtonAndLabelWidget() {
    return Flexible(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Flexible(
            flex: 3,
            child: Text(
              'Will France win the 2024 Euro Cup?',
              style: TextStyles.titleTextSmall,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
                'If you predict correctly,you could earn upto \$6 USD. The price might change over time, track the price in real time in the below chart',
                style: TextStyles.bodyTextMedium),
          ),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: AppColors.contentColorGreen,
                ),
                onPressed: () {},
                child: const Text('Yes 0.9', style: TextStyles.bodyText),
              ),
              const SizedBox(
                width: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: AppColors.contentColorRed,
                ),
                onPressed: () {},
                child: const Text('No 0.5', style: TextStyles.bodyText),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Renders the lable for the time in the x axis
  Widget bottomTitleWidgets(
      double value, TitleMeta meta, ChartController controller) {
    final time = controller.priceHistory.elementAt(value.toInt()).time;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(
        DateFormat(DateFormat.HOUR_MINUTE_SECOND).format(time),
        style: TextStyles.bodySmall,
      ),
    );
  }

  /// Renders the label for price in the y axis
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text('\$${meta.formattedValue}', style: TextStyles.bodyText),
    );
  }

  /// Renders the chart data and its graph
  LineChartData mainData(ChartController controller) {
    return LineChartData(
      clipData: FlClipData.all(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          axisNameWidget: const Text('Price', style: TextStyles.bodyText),
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta),
            reservedSize: 56,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          axisNameWidget: const Text('Time', style: TextStyles.bodyText),
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) =>
                bottomTitleWidgets(value, meta, controller),
            reservedSize: 36,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 5,
      minY: 0,
      maxY: 6,
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          showOnTopOfTheChartBoxArea: true,
          maxContentWidth: 150,
          fitInsideVertically: true,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              return LineTooltipItem(
                'Price: \$${touchedSpot.y.toStringAsFixed(2)}\n'
                'Time: ${DateFormat(DateFormat.HOUR_MINUTE_SECOND).format(controller.priceHistory.elementAt(touchedSpot.x.toInt()).time)}',
                textAlign: TextAlign.start,
                TextStyles.bodyTextBold,
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
        getTouchLineStart: (data, index) => 0,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: controller.priceHistory
              .map(
                (e) => FlSpot(
                  controller.priceHistory.indexOf(e).toDouble(),
                  e.price,
                ),
              )
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: controller.gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: controller.gradientColors
                  .map((color) => color.withOpacity(0.1))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
