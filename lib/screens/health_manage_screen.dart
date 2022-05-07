import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
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
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

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
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepInfomation(
              currentStepNumber: 1000,
              standardStepNumber: 4000,
            ),
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
                      parameter: '2394',
                      parameterUnit: 'm'),
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
                    parameter: '3435',
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
            const Expanded(child: HealthyIndexList()),
          ],
        ),
      ),
    );
  }
}
