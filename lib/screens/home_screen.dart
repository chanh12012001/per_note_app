import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedometer/pedometer.dart';
import 'package:per_note/models/user_model.dart';
import 'package:per_note/screens/chatbot_screen.dart';
import 'package:per_note/screens/widgets/health_manage/step_info.dart';
import 'package:per_note/screens/widgets/home_screen/profile.dart';
import 'package:per_note/screens/widgets/home_screen/slider_image_album.dart';
import 'package:per_note/screens/widgets/schedule_manage/task_list.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:per_note/services/notification_service.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../models/task_model.dart';
import '../preferences/user_preference.dart';
import '../providers/task_provider.dart';

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
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '0';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
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
                      color: Color.fromARGB(255, 60, 137, 231),
                    ),
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
                                                    ""
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
                        fontSize: 20.0,
                        color: grey2Color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StepInfomation(
              currentStepNumber: int.parse(_steps),
              standardStepNumber: 4000,
            ),
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
      floatingActionButton: buildFloatingButton(),
    );
  }

  _showTasks() {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);

    return SizedBox(
      height: 140,
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

  Widget buildFloatingButton() => FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return ChatBotScreen();
            },
          )).then((value) => setState(() {}));
        },
        child: Container(
          height: 60,
          width: 60,
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/bot.png"),
          ),
        ),
      );
}
