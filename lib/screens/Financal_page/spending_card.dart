import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/spending_model.dart';

class SpendingCard extends StatefulWidget {
  final Spending spending;
  final DateTime selectedDate;
  const SpendingCard({Key? key, required this.spending
  , required this.selectedDate
  })
      : super(key: key);

  @override
  State<SpendingCard> createState() => _SpendingCardState();
}

class _SpendingCardState extends State<SpendingCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (size.width - 40) * 0.7,
            child: Row(children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Image.asset(
                  _getIcon(widget.spending.kind ?? 'Khác'),
                  width: 30,
                  height: 30,
                )),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: (size.width - 90) * 0.5,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.spending.kind}",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.spending.date}",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w400),
                      ),
                    ]),
              ),
            ]),
          ),
          Container(
            width: (size.width - 40) * 0.3,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                NumberFormat.currency(locale: 'vi')
                    .format("${widget.spending.money}"),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.green),
              )
            ]),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 50, top: 6),
        child: Divider(
          thickness: 1.5,
        ),
      ),
    ]);
  }

  _getIcon(String kind) {
    switch (kind) {
      case 'Khác':
        return "assests/images/different.png";
      case "Nộp tiền":
        return "assests/images/bank.jpg";
      case "Ăn uống":
        return "assests/images/eat.png";
      case "Mua hàng hóa":
        return "assests/images/shopping.pjg";
      default:
        return "assests/images/different.png";
    }
  }
}
