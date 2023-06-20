import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/detail_healthy_index_model.dart';
import 'package:per_note/models/healthy_index_model.dart';
import 'package:per_note/providers/detail_healthy_index_provider.dart';
import 'package:per_note/providers/healthy_index_provider.dart';
import 'package:per_note/screens/widgets/health_manage/statistical_chart.dart';
import 'package:per_note/screens/widgets/loader.dart';
import 'package:provider/provider.dart';

class HealthyIndexList extends StatefulWidget {
  const HealthyIndexList({Key? key}) : super(key: key);

  @override
  State<HealthyIndexList> createState() => _HealthyIndexListState();
}

class _HealthyIndexListState extends State<HealthyIndexList> {
  @override
  Widget build(BuildContext context) {
    HealthyIndexProvider healthyIndexProvider =
        Provider.of<HealthyIndexProvider>(context);

    return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: FutureBuilder<List<HealthyIndex>>(
          future: healthyIndexProvider.getHealthyIndexList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return snapshot.hasData
                ? GridView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      var healthyIndex = snapshot.data![index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                                return StatisticalChartHealthyIndex(
                                    healthyIndex: healthyIndex);
                              },
                            ));
                          },
                          child: _buildHealthyIndexCard(healthyIndex));
                    },
                  )
                : const Center(
                    child: ColorLoader(),
                  );
          },
        ));
  }

  _buildHealthyIndexCard(HealthyIndex healthyIndex) {
    DetailHealthyIndexProvider detailHealthyIndexProvider =
        Provider.of<DetailHealthyIndexProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: Colors.grey, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 1.0), // shadow direction: bottom right
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).primaryColor.withAlpha(50),
                  ),
                  child: Image.network(
                    healthyIndex.iconUrl!,
                    width: 60,
                  ),
                ),
                SizedBox(
                  width: size.width / 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<DetailHealthyIndex>(
                      future: detailHealthyIndexProvider
                          .getDetailHealthyIndexLastest(healthyIndex.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return snapshot.hasData
                            ? Text(
                                snapshot.data!.indexValue!,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: blueColor,
                                    fontWeight: FontWeight.w600),
                              )
                            : const Text("...");
                      },
                    ),
                    SizedBox(
                      width: size.width / 5,
                      child: Text(
                        healthyIndex.unit!,
                        style: TextStyle(
                          fontSize: 17,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: size.width / 40,
            ),
            Text(
              healthyIndex.name!,
              style: TextStyle(
                  color: blackColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Cân lúc',
              style: TextStyle(
                fontSize: 16,
                color: blackColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            FutureBuilder<DetailHealthyIndex>(
              future: detailHealthyIndexProvider
                  .getDetailHealthyIndexLastest(healthyIndex.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return snapshot.hasData
                    ? Text(
                        "${snapshot.data!.createAtTime!} - ${snapshot.data!.createAtDate!}",
                        style: TextStyle(
                          fontSize: 14,
                          color: blackColor,
                        ),
                      )
                    : const Text("...");
              },
            ),
          ],
        ),
      ),
    );
  }
}
