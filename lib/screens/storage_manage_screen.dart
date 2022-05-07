import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/screens/widgets/storage_manage/album/album_tab.dart';
import 'package:per_note/screens/widgets/storage_manage/notes/note_tab.dart';

class AssetManageScreen extends StatefulWidget {
  static const String routeName = '/asset-manage';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const AssetManageScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const AssetManageScreen({Key? key}) : super(key: key);

  @override
  State<AssetManageScreen> createState() => _AssetManageScreenState();
}

class _AssetManageScreenState extends State<AssetManageScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: blackCoffeeColor),
          elevation: 0,
          backgroundColor: whiteColor,
          title: Text(
            'Lưu trữ',
            style: TextStyle(color: blackColor),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.only(left: 10, right: 10),
            indicator: BoxDecoration(
              color: tealColor,
              borderRadius: BorderRadius.circular(25.0),
            ),
            overlayColor: MaterialStateProperty.all(whiteColor),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(icon: Icon(Icons.note_alt), text: 'Ghi chú'),
              Tab(icon: Icon(Icons.photo_album), text: 'Album'),
              Tab(icon: Icon(Icons.account_box), text: 'Tài khoản'),
            ],
          ),
          titleSpacing: 20,
        ),
        body: TabBarView(
          children: [
            const NoteTab(),
            const AlbumTab(),
            buildPage('Profile Page'),
          ],
        ),
      ),
    );
  }

  Widget buildPage(String text) => Container(
        margin: const EdgeInsets.all(20),
        color: Colors.amber,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      );
}
