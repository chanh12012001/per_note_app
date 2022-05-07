import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:per_note/models/detail_healthy_index_model.dart';
import 'package:per_note/models/healthy_index_model.dart';
import 'package:per_note/providers/detail_healthy_index_provider.dart';
import 'package:per_note/screens/widgets/health_manage/add_healthy_data.dart';
import 'package:per_note/screens/widgets/health_manage/value_healthy_index_list.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../loader.dart';

class StatisticalChartHealthyIndex extends StatefulWidget {
  final HealthyIndex healthyIndex;
  const StatisticalChartHealthyIndex({
    Key? key,
    required this.healthyIndex,
  }) : super(key: key);

  @override
  State<StatisticalChartHealthyIndex> createState() =>
      _StatisticalChartHealthyIndexState();
}

class _StatisticalChartHealthyIndexState
    extends State<StatisticalChartHealthyIndex> {
  List<HealthyIndexData> datas = [];

  @override
  Widget build(BuildContext context) {
    DetailHealthyIndexProvider detailHealthyIndexProvider =
        Provider.of<DetailHealthyIndexProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black38),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Biểu đồ ${widget.healthyIndex.name}',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return AddHealthyData(healthyIndex: widget.healthyIndex);
                },
              ));
            },
            icon: const Icon(Icons.add_box),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Text(
                'Biểu đồ 10 lần đo gần đây nhất',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<DetailHealthyIndex>>(
              future: detailHealthyIndexProvider
                  .getAllDetailHealthyIndexByUserId(widget.healthyIndex.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  List<DetailHealthyIndex> detailHealthyIndexList =
                      snapshot.data!;
                  var time = 1;
                  double subValue1 = 0;
                  for (var data in detailHealthyIndexList) {
                    if (data.indexValue!.contains('/')) {
                      subValue1 = double.parse(data.indexValue!.split('/')[1]);

                      data.indexValue = data.indexValue!.split('/')[0];
                    } else {
                      subValue1 = 0;
                    }
                    datas.add(
                      HealthyIndexData(
                        time.toString(),
                        double.parse(data.indexValue!),
                        subValue1,
                      ),
                    );
                    time++;
                  }
                }
                return snapshot.hasData
                    ? SfCartesianChart(
                        primaryXAxis:
                            CategoryAxis(title: AxisTitle(text: "Lần đo")),
                        primaryYAxis: CategoryAxis(
                            title: AxisTitle(text: widget.healthyIndex.unit),
                            minimum: 5),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <LineSeries<HealthyIndexData, String>>[
                          LineSeries<HealthyIndexData, String>(
                            dataSource: datas,
                            xValueMapper: (HealthyIndexData data, _) =>
                                data.time,
                            yValueMapper: (HealthyIndexData data, _) =>
                                data.value,
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                          ),
                          LineSeries<HealthyIndexData, String>(
                            dataSource: datas,
                            xValueMapper: (HealthyIndexData data, _) =>
                                data.time,
                            yValueMapper: (HealthyIndexData data, _) =>
                                data.subValue,
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                          ),
                        ],
                      )
                    : Container();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lịch sử đo (3 lần)',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: FutureBuilder<List<DetailHealthyIndex>>(
                future: detailHealthyIndexProvider
                    .getAllDetailHealthyIndexByUserId(widget.healthyIndex.id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return snapshot.hasData
                      ? ValueHealthyIndexList(
                          healthyIndex: widget.healthyIndex,
                          detailDealthyIndexList: snapshot.data!)
                      : const Center(
                          child: ColorLoader(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthyIndexData {
  String time;
  double value;
  double subValue;

  HealthyIndexData(this.time, this.value, this.subValue);
}
