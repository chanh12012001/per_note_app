import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/providers/category_provider.dart';
import 'package:per_note/screens/widgets/task_to_do/add_new_task.dart';
import 'package:per_note/screens/widgets/task_to_do/add_task_dialog.dart';
import 'package:per_note/screens/widgets/task_to_do/task_to_do.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category';
  const CategoryScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const CategoryScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black38),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Loại công việc",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddTaskDialog(
                    reload: reload,
                  );
                },
              );
            },
            child: Image.asset(
              "assets/icons/ic_task_add.png",
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: FutureBuilder<List<Category>>(
                  future: categoryProvider.getCategoriesList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.hasError}");
                    }
                    return snapshot.hasData
                        ? StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TaskToDo(
                                category: snapshot.data![index],
                                reload: reload,
                              );
                            },
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.count(
                                    2, index.isEven ? 2.4 : 1.8),
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                          )
                        : const Center(
                            child: ColorLoader(),
                          );
                  },
                ),
              ),
            ),
          ],
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
