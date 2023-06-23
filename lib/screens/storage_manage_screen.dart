import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/screens/widgets/storage_manage/account/account_tab.dart';
import 'package:per_note/screens/widgets/storage_manage/album/album_tab.dart';
// import 'package:per_note/screens/widgets/storage_manage/document/document_tab.dart';
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

class _AssetManageScreenState extends State<AssetManageScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

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
            controller: _tabController,
            padding: const EdgeInsets.only(left: 10, right: 10),
            indicator: BoxDecoration(
              color: tealColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            overlayColor: MaterialStateProperty.all(whiteColor),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            labelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                icon: Image.asset(
                  "assets/icons/ic_note.png",
                  color: _tabController.index == 0
                      ? Colors.white
                      : const Color.fromARGB(255, 7, 72, 125),
                  width: 30,
                  height: 30,
                ),
                text: 'Ghi chú',
              ),
              Tab(
                icon: Image.asset(
                  "assets/icons/ic_photo.png",
                  color: _tabController.index == 1
                      ? Colors.white
                      : const Color.fromARGB(255, 7, 72, 125),
                  width: 30,
                  height: 30,
                ),
                text: 'Album ảnh',
              ),
              Tab(
                icon: Image.asset(
                  "assets/icons/ic_profile.png",
                  color: _tabController.index == 2
                      ? Colors.white
                      : const Color.fromARGB(255, 7, 72, 125),
                  width: 30,
                  height: 30,
                ),
                text: 'Tài khoản',
              ),
            ],
          ),
          titleSpacing: 20,
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            NoteTab(),
            AlbumTab(),
            AccountTab(),
          ],
        ),
      ),
    );
  }
}
