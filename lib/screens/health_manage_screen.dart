import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/screens/chatbot_screen.dart';
import 'package:per_note/screens/widgets/health_manage/add_edit_healthy_index_dialog.dart';
import 'package:per_note/screens/widgets/health_manage/card_info_base_steps.dart';
import 'package:per_note/screens/widgets/health_manage/healthy_index_list.dart';
import 'package:per_note/screens/widgets/health_manage/step_info.dart';

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
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '0';
  String _km = '0';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black38),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Thông tin sức khoẻ',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [],
      ),
      floatingActionButton: buildFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // StepInfomation(
              //   currentStepNumber: int.parse(_steps),
              //   standardStepNumber: 4000,
              // ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CardInfomationBaseSteps(
                        startColorLinearGradient: const Color(0xff42E695),
                        endColorLinearGradient: const Color(0xff3BB2B8),
                        title: 'Distance',
                        image: Image.asset('assets/images/distance.png'),
                        parameter: getDistanceRun(double.parse(_steps)),
                        parameterUnit: 'km'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CardInfomationBaseSteps(
                      startColorLinearGradient: const Color(0xffFFB157),
                      endColorLinearGradient: const Color(0xffFFA057),
                      title: 'Calories',
                      image: Image.asset('assets/images/calories.png'),
                      parameter:
                          calculateCalories(int.parse(_steps)).toString(),
                      parameterUnit: 'kCal',
                    ),
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
                    'Chỉ số sức khoẻ',
                    style: TextStyle(
                      color: blueColor,
                      fontSize: 23,
                      fontFamily: 'Bebas',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AddAndEditHealthyIndexDialog();
                        },
                      );
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: greyColor,
                    ),
                  ),
                ],
              ),
              const HealthyIndexList(),
            ],
          ),
        ),
      ),
    );
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  void onStepCountError(error) {
    setState(() {
      _steps = '0';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  //function to determine the distance run in kilometers using number of steps
  String getDistanceRun(double numStep) {
    var distance = ((numStep * 78) / 100000);
    distance = double.parse(distance.toStringAsFixed(2)); //dos decimales
    var distancekmx = distance * 34;
    distancekmx = double.parse(distancekmx.toStringAsFixed(2));
    setState(() {
      _km = "$distance";
    });
    return _km;
  }

  String calculateCalories(int steps) {
    double caloriesValue = (steps * 0.0566);
    return caloriesValue.toStringAsFixed(2);
  }

  Widget buildFloatingButton() => FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return const ChatBotScreen();
            },
          )).then((value) => setState(() {}));
        },
        child: const SizedBox(
          height: 80,
          width: 80,
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/bot.png"),
          ),
        ),
      );
}
