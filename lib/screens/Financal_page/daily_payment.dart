import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:per_note/models/spending_model.dart';
import 'package:per_note/providers/spending_provider.dart';
import 'package:per_note/screens/Financal_page/date_time.dart';
import 'package:per_note/screens/Financal_page/spending_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DailyPayment extends StatefulWidget {
  const DailyPayment({Key? key}) : super(key: key);

  @override
  State<DailyPayment> createState() => _DailyPaymentState();
}

class _DailyPaymentState extends State<DailyPayment> {
  int dayChoose = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.06),
      body: walletBody(),
    );
  }

  Widget walletBody() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.01),
              spreadRadius: 10,
              blurRadius: 3,
            ),
          ]),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 60, bottom: 25, right: 20, left: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Chi Tiêu Hằng Ngày',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(days.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        dayChoose = index;
                      });
                    },
                    child: Container(
                      width: (size.width - 40) / 7,
                      child: Column(children: [
                        Text(
                          days[index]['label'],
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: dayChoose == index
                                ? Colors.blueAccent
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: dayChoose == index
                                    ? Colors.blueAccent
                                    : Colors.black.withOpacity(0.1)),
                          ),
                          child: Center(
                            child: Text(
                              days[index]['day'],
                              style: TextStyle(
                                  fontSize: 10,
                                  color: dayChoose == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
              ),
            ]),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Consumer<SpendingProvider>(
                  builder: (context, spendingProvider, child) {
                var spendings = spendingProvider.getSpendings;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: spendings.length,
                  itemBuilder: (context, index) {
                    Spending spending = spendings[index];
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SpendingCard(
                          spending: spending,
                          selectedDate: days[dayChoose]['day'],
                        ),
                        );
                  },
                );
              }),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Row(
            children: [
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng chi tiêu: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  Text(
                    NumberFormat.currency(locale: 'vi').format(0),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
