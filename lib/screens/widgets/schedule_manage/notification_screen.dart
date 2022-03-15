import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:per_note/config/theme.dart';

class NotificationScreen extends StatelessWidget {
  final String payload;
  const NotificationScreen({
    Key? key,
    required this.payload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = payload.toString().split('|')[0];
    String note = payload.toString().split('|')[1];
    String startTime = payload.toString().split('|')[2];
    String endTime = payload.toString().split('|')[3];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Xin Chào Phạm Văn Chánh!',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Bạn có 1 công việc hôm nay',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Container(
              width: size.width,
              height: size.width,
              decoration: BoxDecoration(
                color: tealColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleNotifyWidget(
                        title: 'Chủ đề',
                        icon: Icons.title_rounded,
                      ),
                      const SizedBox(height: 15),
                      _buildSubTitleNotifyWidget(text: title),
                      const SizedBox(height: 20),
                      _buildTitleNotifyWidget(
                        title: 'Ghi chú',
                        icon: Icons.description_outlined,
                      ),
                      const SizedBox(height: 15),
                      _buildSubTitleNotifyWidget(
                        text: note,
                      ),
                      const SizedBox(height: 20),
                      _buildTitleNotifyWidget(
                        title: 'Thời gian',
                        icon: Icons.date_range,
                      ),
                      const SizedBox(height: 15),
                      _buildSubTitleNotifyWidget(
                        text: '$startTime - $endTime',
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.work_outline,
                            color: whiteColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Chúc bạn thành công',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTitleNotifyWidget({required String title, required IconData icon}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 28,
          color: whiteColor,
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          title,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 25,
              color: whiteColor,
            ),
          ),
        ),
      ],
    );
  }

  _buildSubTitleNotifyWidget({required String text}) {
    return Text(
      text,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 19,
          color: whiteColor,
        ),
      ),
    );
  }
}
