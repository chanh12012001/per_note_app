import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/screens/widgets/health_manage/card_info_base_steps.dart';
import 'package:per_note/screens/widgets/health_manage/step_info.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HealthManageScreen extends StatefulWidget {
  static const String routeName = '/health-manage';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HealthManageScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HealthManageScreen({Key? key}) : super(key: key);

  @override
  State<HealthManageScreen> createState() => _HealthManageScreenState();
}

class _HealthManageScreenState extends State<HealthManageScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black38),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Thông tin sức khoẻ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 30, 25, 25),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const StepInfomation(
                  currentStepNumber: 1000,
                  standardStepNumber: 4000,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CardInfomationBaseSteps(
                        startColorLinearGradient: const Color(0xff42E695),
                        endColorLinearGradient: const Color(0xff3BB2B8),
                        title: 'Distance',
                        image: Image.asset('assets/images/distance.png'),
                        parameter: '2394',
                        parameterUnit: 'm'),
                    const SizedBox(
                      width: 10,
                    ),
                    CardInfomationBaseSteps(
                      startColorLinearGradient: const Color(0xffFFB157),
                      endColorLinearGradient: const Color(0xffFFA057),
                      title: 'Calories',
                      image: Image.asset('assets/images/calories.png'),
                      parameter: '3435',
                      parameterUnit: 'kCal',
                    )
                  ],
                ),
                Divider(
                  height: 25,
                  color: Colors.grey[300],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'DIET PROGRESS',
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 24,
                        fontFamily: 'Bebas',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/down_orange.png',
                          width: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 15),
                        ),
                        const Text(
                          '500 Calories',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  height: 300,
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      StatCard(
                        title: 'Carbs',
                        achieved: 200,
                        total: 350,
                        color: Colors.orange,
                        image: Image.asset('assets/images/bolt.png', width: 20),
                      ),
                      StatCard(
                        title: 'Protien',
                        achieved: 350,
                        total: 300,
                        color: Theme.of(context).primaryColor,
                        image: Image.asset('assets/images/fish.png', width: 20),
                      ),
                      StatCard(
                        title: 'Fats',
                        achieved: 100,
                        total: 200,
                        color: Colors.green,
                        image:
                            Image.asset('assets/images/sausage.png', width: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final double total;
  final double achieved;
  final Image image;
  final Color color;

  const StatCard({
    Key? key,
    required this.title,
    required this.total,
    required this.achieved,
    required this.image,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: blueColor?.withAlpha(100),
                  fontSize: 14,
                ),
              ),
              achieved < total
                  ? Image.asset(
                      'assets/images/down_orange.png',
                      width: 20,
                    )
                  : Image.asset(
                      'assets/images/up_red.png',
                      width: 20,
                    ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 8.0,
            percent: achieved / (total < achieved ? achieved : total),
            circularStrokeCap: CircularStrokeCap.round,
            center: image,
            progressColor: color,
            backgroundColor: blueColor!.withAlpha(30),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: achieved.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: blueColor,
                ),
              ),
              TextSpan(
                text: ' / $total',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
