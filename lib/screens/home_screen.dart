import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
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
import '../providers/task_provider.dart';

class HomeScreen extends StatefulWidget {
  // static const String routeName = '/home';

  // static Route route() {
  //   return MaterialPageRoute(
  //     builder: (_) => const HomeScreen(),
  //     settings: const RouteSettings(name: routeName),
  //   );
  // }

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height / 2,
                ),
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: size.width / 2,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 60, 137, 231),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return Profile(user: widget.user);
                                    },
                                  )).then((value) => setState(() {}));
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.amberAccent,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Xin chào Phạm Văn Chánh',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 20.0,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  width: size.width,
                  height: size.width,
                  top: size.width / 3,
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
            const StepInfomation(
              currentStepNumber: 1000,
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
