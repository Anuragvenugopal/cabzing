import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import 'package:cabzing/utils/app_colors.dart';

class AreaChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lite_black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Center(
          child: MaterialAreaChart(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 400,
            interactive: true,
            style: AreaChartStyle(
              backgroundColor: AppColors.lite_black,
              gridColor: AppColors.white,
              showGrid: true,
              showPoints: false,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(seconds: 1),
            ),
            series: [
              AreaChartSeries(

                name: 'Revenue',
                dataPoints: [
                  AreaChartData(value: 500, label: '01'),
                  AreaChartData(value: 800, label: '02'),
                  AreaChartData(value: 3000, label: '03'),
                  AreaChartData(value: 1500, label: '04'),
                  AreaChartData(value: 2000, label: '05'),
                  AreaChartData(value: 3500, label: '06'),
                  AreaChartData(value: 2700, label: '07'),
                  AreaChartData(value: 2000, label: '08'),
                ],
                color: AppColors.blue.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
