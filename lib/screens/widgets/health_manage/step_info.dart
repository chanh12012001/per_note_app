import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../config/theme.dart';

class StepInfomation extends StatefulWidget {
  final int currentStepNumber;
  final int standardStepNumber;
  const StepInfomation({
    Key? key,
    required this.currentStepNumber,
    required this.standardStepNumber,
  }) : super(key: key);

  @override
  State<StepInfomation> createState() => _StepInfomationState();
}

class _StepInfomationState extends State<StepInfomation> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/running.gif',
            width: size.width / 3.5,
            height: size.width / 3.5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              CircularPercentIndicator(
                radius: size.width / 4.5,
                lineWidth: 8.0,
                percent: 0.7,
                circularStrokeCap: CircularStrokeCap.round,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).primaryColor.withAlpha(50),
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
                        Text(
                          '${widget.currentStepNumber}',
                          style: TextStyle(
                            color: tealColor,
                            fontSize: 20,
                            fontFamily: 'Bebas',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' / ${widget.standardStepNumber}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
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
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                progressColor: Colors.green,
                backgroundColor: blueColor!.withAlpha(30),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 25),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
