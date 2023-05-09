import 'package:flutter/material.dart';
import 'package:orcamento_app/model/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  final String nome;
  final List<ChartData> data;
  const PieChart({super.key, required this.nome, required this.data});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(
        textStyle: TextStyle(fontSize: 13),
        isVisible: true,
        height: '100%',
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: data,
          name: nome,
          dataLabelSettings: const DataLabelSettings(
            labelAlignment: ChartDataLabelAlignment.middle,
            connectorLineSettings: ConnectorLineSettings(
              width: 2,
              type: ConnectorType.curve,
            ),
            overflowMode: OverflowMode.shift,
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
          ),
          dataLabelMapper: (ChartData data, _) => data.porcentagem,
          xValueMapper: (ChartData data, _) => data.nome,
          yValueMapper: (ChartData data, _) => data.valor,
        )
      ],
    );
  }
}
