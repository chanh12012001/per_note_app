import 'package:flutter/material.dart';

class FinancialScreen extends StatelessWidget {
  static const String routeName = '/finan';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const FinancialScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const FinancialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            toolbarHeight: size.height * 0.11,
            backgroundColor: const Color.fromARGB(255, 2, 175, 174),
            elevation: 0,
            leading: Row(children: [
              Container(
                width: 56,
                padding: EdgeInsets.only(left: 1.5),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    child:
                        Image.asset('assets/images/avt.jpg', fit: BoxFit.fill),
                  ),
                ),
              ),
            ]),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'HO QUANG',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  'Xem thông tin',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(
                //     Icons.arrow_drop_down,
                //     color: Colors.black,
                //   ),
                // ),
              ],
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: <Widget>[
              Container(
                height: size.height * 0.07,
                color: const Color.fromARGB(255, 2, 175, 174),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                    )
                  ],
                ),
              ),
              Container(
                height: size.height - size.height * 0.18,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Button ví tiền
                        Column(
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.money_rounded,
                                size: 30,
                              ),
                              onPressed: () {},
                              label: Text(
                                'Ví tiền',
                                style: TextStyle(fontSize: 25),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20),
                                ),
                                primary: Color.fromARGB(255, 254, 135, 111),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 40),
                                shadowColor: Color.fromARGB(255, 245, 145, 145),
                              ),
                            ),
                          ],
                        ),
                        //Button
                        Column(
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.data_thresholding,
                                size: 30,
                              ),
                              onPressed: () {},
                              label: Text(
                                'Báo cáo',
                                style: TextStyle(fontSize: 25),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20),
                                ),
                                primary: Color.fromARGB(255, 254, 135, 111),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 40),
                                shadowColor: Color.fromARGB(255, 177, 227, 247),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          height: size.height * 0.4,
                          width: size.width * 0.4,
                          color: Color.fromARGB(255, 254, 135, 111)
                              .withOpacity(0.1),
                          child: Column(
                            children: [
                              Text(
                                'Số tiền',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 114, 113, 113)),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove_red_eye,
                                      color: Colors.grey)),
                              Text(
                                '5.000.000vnđ',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Nộp thêm tiền vào ví',
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 2, 175, 174)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Trừ số tiền đã sử dụng',
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 2, 175, 174)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Đặt hạn mức',
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 2, 175, 174)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          height: size.height * 0.4,
                          width: size.width * 0.4,
                          color: Color.fromARGB(255, 254, 135, 111)
                              .withOpacity(0.1),
                          child: Column(
                            children: [
                              Container(
                                height: size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Báo cáo ngày',
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 2, 175, 174)),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Báo cáo tuần',
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 2, 175, 174)),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Báo cáo tháng',
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 2, 175, 174)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
