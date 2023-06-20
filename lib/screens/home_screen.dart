import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedometer/pedometer.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/models/user_model.dart';
import 'package:per_note/providers/category_provider.dart';
import 'package:per_note/screens/widgets/health_manage/step_info.dart';
import 'package:per_note/screens/widgets/home_screen/profile.dart';
import 'package:per_note/screens/widgets/home_screen/slider_image_album.dart';
import 'package:per_note/screens/widgets/schedule_manage/task_list.dart';
import 'package:per_note/screens/widgets/task_to_do/add_new_task.dart';
import 'package:per_note/screens/widgets/task_to_do/dialog_add_new.dart';
import 'package:per_note/screens/widgets/task_to_do/task_to_do.dart';
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
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
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
                    child: Image.asset('assets/images/ic_listcheck.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Việc cần làm',
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
            _showTaskToDo(categoryProvider),
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

  _showTaskToDo(CategoryProvider categoryProvider) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: 500,
        child: FutureBuilder<List<Category>>(
          future: categoryProvider.getCategoriesList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.hasError}");
            }
            return snapshot.hasData
                ? Column(
                    children: [
                      AddTaskButton(
                        categories: snapshot.data!,
                        reload: reload,
                        ),
                      Expanded(
                        child: GridView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) =>
                                index == snapshot.data!.length
                                    ? AddNewTask(
                                        reload: reload,
                                      )
                                    : TaskToDo(
                                        category: snapshot.data![index],
                                        reload: reload,
                                      )),
                      ),
                    ],
                  )
                : const Center(
                    child: ColorLoader(),
                  );
          },
        ),
      ),
    );
  }

  Future<String> reload() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Việc cần làm'),
        content: Text('Thành công'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
    return "";
  }
}
