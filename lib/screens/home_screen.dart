import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedometer/pedometer.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/models/user_model.dart';
import 'package:per_note/providers/category_provider.dart';
import 'package:per_note/screens/widgets/home_screen/profile.dart';
import 'package:per_note/screens/widgets/home_screen/slider_image_album.dart';
import 'package:per_note/screens/widgets/schedule_manage/task_list.dart';
import 'package:per_note/screens/widgets/task_to_do/add_new_task.dart';
import 'package:per_note/screens/widgets/task_to_do/task_to_do.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:per_note/services/notification_service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../models/task_model.dart';
import '../preferences/user_preference.dart';
import '../providers/task_provider.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService notifyService = NotificationService();
  // late Stream<StepCount> _stepCountStream;
  // late Stream<PedestrianStatus> _pedestrianStatusStream;

  // String _status = '?', _steps = '0';
  // String _km = '0';

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // void onStepCount(StepCount event) {
  //   print(event);
  //   setState(() {
  //     _steps = event.steps.toString();
  //   });
  // }

  // void onPedestrianStatusChanged(PedestrianStatus event) {
  //   print(event);
  //   setState(() {
  //     _status = event.status;
  //   });
  // }

  // void onPedestrianStatusError(error) {
  //   print('onPedestrianStatusError: $error');
  //   setState(() {
  //     _status = 'Pedestrian Status not available';
  //   });
  //   print(_status);
  // }

  // void onStepCountError(error) {
  //   print('onStepCountError: $error');
  //   setState(() {
  //     _steps = '0';
  //   });
  // }

  // void initPlatformState() {
  //   _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
  //   _pedestrianStatusStream
  //       .listen(onPedestrianStatusChanged)
  //       .onError(onPedestrianStatusError);

  //   _stepCountStream = Pedometer.stepCountStream;
  //   _stepCountStream.listen(onStepCount).onError(onStepCountError);

  //   if (!mounted) return;
  // }

  //function to determine the distance run in kilometers using number of steps
  // String getDistanceRun(double numStep) {
  //   var distance = ((numStep * 78) / 100000);
  //   distance = double.parse(distance.toStringAsFixed(2)); //dos decimales
  //   var distancekmx = distance * 34;
  //   distancekmx = double.parse(distancekmx.toStringAsFixed(2));
  //   setState(() {
  //     _km = "$distance";
  //   });
  //   return _km;
  // }

  // String calculateCalories(int steps) {
  //   double caloriesValue = (steps * 0.0566);
  //   return caloriesValue.toStringAsFixed(2);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserPreferences userPreferences = UserPreferences();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 430,
                ),
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff4568dc),
                        Color(0xffb06ab3),
                      ],
                    )),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: FutureBuilder<User>(
                            future: userPreferences.getUser(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return snapshot.hasData
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute<void>(
                                              builder: (BuildContext context) {
                                                return Profile(
                                                    user: snapshot.data!);
                                              },
                                            )).then((value) => setState(() {}));
                                          },
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: snapshot
                                                        .data!.avatarUrl !=
                                                    null
                                                ? NetworkImage(
                                                    snapshot.data!.avatarUrl!)
                                                : const AssetImage(
                                                        'assets/images/photo_gallery.png')
                                                    as ImageProvider,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Xin chào ${snapshot.data!.name}',
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              fontSize: 20.0,
                                              color: whiteColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  width: size.width,
                  height: size.width,
                  top: 140,
                  child: const CarouselSliderImageAlbum(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/shoe.png',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Đi bộ mỗi ngày',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        color: grey2Color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/running.gif',
                    width: 90,
                    height: 90,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularPercentIndicator(
                        radius: size.width / 6,
                        lineWidth: 6,
                        percent: 0.7,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(50),
                              ),
                              child: Image.asset(
                                'assets/images/shoe.png',
                                width: 60,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text(
                                //   '${int.parse(_steps)}',
                                //   style: TextStyle(
                                //     color: tealColor,
                                //     fontSize: 16,
                                //     fontFamily: 'Bebas',
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Text(
                                  ' / ${4000}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontFamily: 'Bebas',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'bước',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: blueColor!.withAlpha(30),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  // Expanded(
                  //   child: Column(
                  //     children: [
                  //       CardInfomationBaseSteps(
                  //           startColorLinearGradient: const Color(0xff42E695),
                  //           endColorLinearGradient: const Color(0xff3BB2B8),
                  //           title: 'Distance',
                  //           image: Image.asset('assets/images/distance.png'),
                  //           parameter: getDistanceRun(double.parse(_steps)),
                  //           parameterUnit: 'km'),
                  //       const SizedBox(height: 10),
                  //       CardInfomationBaseSteps(
                  //         startColorLinearGradient: const Color(0xffFFB157),
                  //         endColorLinearGradient: const Color(0xffFFA057),
                  //         title: 'Calories',
                  //         image: Image.asset('assets/images/calories.png'),
                  //         parameter:
                  //             calculateCalories(int.parse(_steps)).toString(),
                  //         parameterUnit: 'kCal',
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    child: Image.asset('assets/images/ic_date.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Hôm nay',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        color: grey2Color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  _showTasks() {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);

    return SizedBox(
      height: 150,
      child: FutureBuilder<List<Task>>(
        future: taskProvider.getTasksList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return snapshot.hasData
              ? TaskList(
                  tasks: snapshot.data!,
                  selectedDate: DateTime.now(),
                  scrollDirection: Axis.horizontal,
                )
              : const Center(
                  child: ColorLoader(),
                );
        },
      ),
    );
  }
}

class CardInfomationBaseSteps extends StatelessWidget {
  final Color startColorLinearGradient;
  final Color endColorLinearGradient;
  final String title;
  final Image image;
  final String parameter;
  final String parameterUnit;
  const CardInfomationBaseSteps({
    Key? key,
    required this.startColorLinearGradient,
    required this.endColorLinearGradient,
    required this.title,
    required this.image,
    required this.parameter,
    required this.parameterUnit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 24;

    return Stack(
      children: [
        Container(
          height: 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            gradient: LinearGradient(
              colors: [
                startColorLinearGradient,
                endColorLinearGradient,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          top: 0,
          child: CustomPaint(
            size: const Size(100, 150),
            painter: CustomCardShapePainter(
              borderRadius,
              startColorLinearGradient,
              endColorLinearGradient,
            ),
          ),
        ),
        Positioned.fill(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: image,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Avenir',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: parameter,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 39, 108, 165),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' $parameterUnit',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(
          size.width,
          size.height,
        ),
        [
          HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
          endColor
        ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
